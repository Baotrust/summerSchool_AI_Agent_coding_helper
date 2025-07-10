# 🧰 Local Python CLI Agent (Cross-Platform)

> This script allows students to interact with a local LLM (e.g. Mistral-7B) using a terminal interface. It keeps conversation history and supports control commands.

---

## 📄 Script: `converse-local.py`

```python
import subprocess
import os

THIS_DIR = os.path.dirname(os.path.abspath(__file__))
ROOT_DIR = os.path.abspath(os.path.join(THIS_DIR, ".."))

MODEL_PATH = os.path.join(ROOT_DIR, "models", "mistral-7b-instruct-v0.1.Q6_K.gguf")
LLAMA_CLI = os.path.join(ROOT_DIR, "build", "bin", "llama-cli")
MAX_TOKENS = 800

print("\U0001F4DA Fiction Writing Assistant (type 'exit' to quit, 'restart' to repeat the last request, 'clear' to reset story)\n")

history = []  # Keeps track of full story interaction

while True:
    user_input = input("\U0001F9D1‍\U0001F4BB You: ").strip()

    if user_input.lower() in ["exit", "quit"]:
        break
    elif user_input.lower() in ["clear", "reset"]:
        history = []
        print("\U0001F9F9 Story history cleared.")
        continue
    elif user_input.lower() in ["restart", "recommence"]:
        if not history:
            print("⚠️ No previous story to regenerate.")
            continue
        prompt = history[-1]["user"]
    else:
        prompt = user_input

    # Build full prompt from history + new input
    context = ""
    for turn in history:
        context += f"You: {turn['user']}\nAI: {turn['ai']}\n"
    context += f"You: {prompt}\nAI:"

    cmd = [
        LLAMA_CLI,
        "-m", MODEL_PATH,
        "-p", context,
        "-n", str(MAX_TOKENS),
        "--color"
    ]

    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        output_lines = result.stdout.strip().split("\n")
        content_lines = [
            line.strip() for line in output_lines
            if line.strip() and not line.startswith(("llama_", "ggml_", "main:", "load:", "print_info:"))
        ]

        if content_lines:
            ai_response = "\n".join(content_lines)
            print("\U0001F4D6 AI:", ai_response)
            history.append({"user": prompt, "ai": ai_response})
        else:
            print("\U0001F916 AI: (no useful output)")
    except subprocess.CalledProcessError as e:
        print("❌ Error:", e)
```

---

## 💡 Usage Instructions

- Ensure the `mistral-7b-instruct-v0.1.Q6_K.gguf` model is located in the `models/` folder.
- Run the script from the `llama.cpp/` root:

```bash
python scripts/converse-local.py
```

### CLI Commands

- `exit` or `quit`: Leave the assistant
- `clear` or `reset`: Clear full conversation history
- `restart` or `recommence`: Re-run last prompt

---

## 🖥 Platform Compatibility

- ✅ macOS, Windows (via WSL or Git Bash), Linux
- Requires Python 3.8+, `llama-cli` binary, and downloaded GGUF model

---

This script will be used in the second half of the workshop to guide students in local agent development and prompt chaining for advanced reasoning workflows.
