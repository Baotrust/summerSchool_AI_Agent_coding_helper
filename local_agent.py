
import os
import sqlite3
import subprocess
import sys

# === STUDENTS: MODIFY THESE PATHS FOR YOUR SYSTEM ===
DEVELOPMENT_DIR = os.environ.get("DEVELOPMENT_DIR", os.path.expanduser("~/development"))
LLAMA_COMPLETION = os.environ.get(
    "LLAMA_COMPLETION",
    os.path.join(DEVELOPMENT_DIR, "llama.cpp-stable", "build", "bin", "llama-completion"),
)
MODEL_PATH = os.environ.get(
    "MODEL_PATH",
    os.path.join(DEVELOPMENT_DIR, "AI-models", "llm", "Mistral-7B-Instruct-v0.3-Q6_K.gguf"),
)
MAX_TOKENS = 800
BASE_DEV_PATH = DEVELOPMENT_DIR


def run_llm(prompt, max_tokens=MAX_TOKENS):
    if not os.path.exists(LLAMA_COMPLETION):
        print(f"❌ llama-completion not found: {LLAMA_COMPLETION}")
        sys.exit(1)
    if not os.path.exists(MODEL_PATH):
        print(f"❌ Model not found: {MODEL_PATH}")
        sys.exit(1)

    cmd = [
        LLAMA_COMPLETION,
        "-m", MODEL_PATH,
        "-p", f"[INST] {prompt} [/INST]",
        "-n", str(max_tokens),
        "--no-display-prompt",
        "-no-cnv",
        "--device", "none",
        "-ngl", "0",
        "--no-op-offload",
    ]
    result = subprocess.run(cmd, check=True, capture_output=True, text=True)
    return result.stdout.strip()

# === PROJECT SELECTION ===
def select_project(base_path):
    if not os.path.exists(base_path):
        print(f"❌ Base dev folder not found: {base_path}")
        sys.exit(1)

    subfolders = [f for f in os.listdir(base_path) if os.path.isdir(os.path.join(base_path, f))]
    if not subfolders:
        print(f"❌ No projects found in: {base_path}")
        sys.exit(1)

    print("\n📂 Available Projects:")
    for i, folder in enumerate(subfolders, start=1):
        print(f"{i}. {folder}")

    while True:
        choice = input("\n🔢 Select a project number: ").strip()
        if choice.isdigit() and 1 <= int(choice) <= len(subfolders):
            selected = subfolders[int(choice) - 1]
            full_path = os.path.join(base_path, selected)
            print(f"✅ Selected project: {selected} ({full_path})\n")
            return full_path
        else:
            print("❌ Invalid selection. Try again.")

PROJECT_PATH = select_project(BASE_DEV_PATH)
project_name = os.path.basename(PROJECT_PATH)

# === DATABASE CONNECTION ===
def get_db():
    return sqlite3.connect("memory/agent_memory.db")

def get_or_create_project(name, path):
    conn = get_db()
    c = conn.cursor()
    c.execute("SELECT id FROM projects WHERE name = ?", (name,))
    row = c.fetchone()
    if row:
        conn.close()
        return row[0]
    c.execute("INSERT INTO projects (name, path) VALUES (?, ?)", (name, path))
    conn.commit()
    project_id = c.lastrowid
    conn.close()
    return project_id

PROJECT_ID = get_or_create_project(project_name, PROJECT_PATH)

# === PROJECT STRUCTURE SUMMARY (following tutorial logic) ===
def summarize_project_structure(base_path, max_depth=3):
    summary = []

    def walk(dir_path, depth):
        if depth > max_depth:
            return
        try:
            entries = os.listdir(dir_path)
        except Exception:
            return

        rel_path = os.path.relpath(dir_path, base_path)
        indent = "  " * (depth - 1)
        summary.append(f"{indent}- 📁 {rel_path}/")

        key_files = [
            f for f in os.listdir(dir_path)
            if os.path.isfile(os.path.join(dir_path, f)) and (
                f.endswith(('.py', '.js', '.ts', '.ipynb', '.java'))
                or f in ["requirements.txt", "Dockerfile", "package.json"]
            )
        ]
        for f in key_files:
            summary.append(f"{indent}  - 📄 {f}")

        for entry in entries:
            full_path = os.path.join(dir_path, entry)
            if os.path.isdir(full_path):
                walk(full_path, depth + 1)

    walk(base_path, 1)
    return "\n".join(summary)

project_structure = summarize_project_structure(PROJECT_PATH, max_depth=3)[:1000]

# === Silent Summarization via LLM ===
silent_prompt = (
    f"<|system|>\nYou are a code assistant. Here's the structure of the project '{project_name}':\n"
    f"{project_structure}\n"
    "Provide a short summary of what this project seems to be about, mentioning the main technologies if visible.\n"
    "<|user|>\nSummarize this project.\n<|assistant|>\n"
)
project_summary = run_llm(silent_prompt, max_tokens=300)

print("\n🤖 Project Summary:\n", project_summary)

conn = get_db()
c = conn.cursor()
c.execute("UPDATE projects SET summary = ? WHERE id = ?", (project_summary, PROJECT_ID))
conn.commit()
conn.close()

# === RECENT HISTORY + PROMPT ===
def get_recent_history(project_id, n=3):
    conn = get_db()
    c = conn.cursor()
    c.execute("SELECT prompt, response FROM prompts WHERE project_id = ? ORDER BY id DESC LIMIT ?", (project_id, n))
    rows = c.fetchall()
    conn.close()
    return rows[::-1]

def build_prompt(project_name, project_summary, recent_history, user_input):
    system_message = (
        f"You are a helpful coding assistant working on the project '{project_name}'.\n"
        f"Project file summary:\n{project_summary}\n"
        "Answer concisely, focus on technical accuracy, and avoid hallucinations.\n\n"
    )
    history_messages = "".join([f"Q: {p}\nA: {r}\n" for p, r in recent_history])
    current_prompt = f"Q: {user_input}\nA:"
    return system_message + history_messages + current_prompt

print("\n🤖 Local Dev Assistant — type 'exit' to quit.\n")

while True:
    user_input = input("🧑‍💻 You: ").strip()
    if user_input.lower() in ["exit", "quit"]:
        break

    recent_history = get_recent_history(PROJECT_ID)
    prompt = build_prompt(project_name, project_summary, recent_history, user_input)
    answer = run_llm(prompt, max_tokens=MAX_TOKENS)
    print("🤖 AI:", answer)

    conn = get_db()
    c = conn.cursor()
    c.execute("INSERT INTO prompts (project_id, prompt, response) VALUES (?, ?, ?)", (PROJECT_ID, user_input, answer))
    conn.commit()
    conn.close()
