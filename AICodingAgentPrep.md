# 🤖 AI Coding Agent Setup (Part 2)

This document continues the setup for your **local AI agent** based on Mistral and `llama.cpp`, preparing it to serve as a **code-aware development assistant**.

---

## ✅ Prerequisites Recap

Make sure you've completed:

- ✅ Installed `llama.cpp` and compiled the CLI binary
- ✅ Downloaded a suitable Mistral model (e.g. `Q4_K` or `Q8_K`)
- ✅ Successfully tested `local_agent.py` for prompt-based conversation

If not, refer back to the platform-specific setup files (macOS, Windows, Linux).

---

## 🌎 Define Your Developer Workspace

To help the AI agent work on your code:

1. Create a base folder where you store your code projects, e.g.:

   ```bash
   mkdir -p ~/dev
   ```

2. Move your sample projects into that folder:

   ```bash
   mv ~/Downloads/my-python-project ~/dev/
   ```

3. Adjust the Python script to define this base path:

   ```python
   BASE_DEV_PATH = os.path.expanduser("~/dev")
   ```

   > ⚠️ Students must **edit this path** to fit their system.

---

## 🧹 Project Selection Logic

Add the following to your `local_agent.py` to let users pick which project to load:

```python
# === STUDENTS: SET THIS TO YOUR DEV FOLDER ===
BASE_DEV_PATH = "/Users/paul/development/"  # macOS/Linux example
# BASE_DEV_PATH = "C:\\Users\\YourName\\dev"  # Windows example

# === Select a Project ===
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
```

---

## 🧰 Add SQLite Memory for Persistence

### 🗃️ 1. Initialize the SQLite DB

Create a script at `scripts/init_db.py`:

```python
import sqlite3

conn = sqlite3.connect("memory/agent_memory.db")
c = conn.cursor()

# Create tables
c.execute("""
CREATE TABLE IF NOT EXISTS projects (
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    path TEXT NOT NULL,
    summary TEXT
);
""")

c.execute("""
CREATE TABLE IF NOT EXISTS files (
    id INTEGER PRIMARY KEY,
    project_id INTEGER,
    path TEXT,
    notes TEXT,
    FOREIGN KEY(project_id) REFERENCES projects(id)
);
""")

c.execute("""
CREATE TABLE IF NOT EXISTS prompts (
    id INTEGER PRIMARY KEY,
    project_id INTEGER,
    prompt TEXT,
    response TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(project_id) REFERENCES projects(id)
);
""")

conn.commit()
conn.close()
print("✅ SQLite DB initialized.")
```

Run this setup once:

```bash
python3 scripts/init_db.py
```

---

### 📂 2. Add DB Connection in `local_agent.py`

Insert:

```python
import sqlite3

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
```

Then retrieve the selected project:

```python
project_name = os.path.basename(PROJECT_PATH)
PROJECT_ID = get_or_create_project(project_name, PROJECT_PATH)
```

---

### 🔄 Example: Storing Data

```python
# Save a prompt/response pair
conn = get_db()
c = conn.cursor()
c.execute("INSERT INTO prompts (project_id, prompt, response) VALUES (?, ?, ?)", (PROJECT_ID, prompt, ai_response))
conn.commit()
conn.close()
```

---

## 🚀 You’re Set to Continue

Now your agent supports:

- Persistent memory of project-level prompts
- SQLite-based tracking of interaction history
- Solid base for future tuning or evaluations

From the root of `llama.cpp`, run:

```bash
python3 scripts/local_agent.py
```
