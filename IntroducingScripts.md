# 🧪 Getting Started with Your Local AI Agent

This tutorial guides you through verifying your Python environment and preparing to run your local AI agent script (`local_agent.py`). This script will serve as the base for an intelligent coding assistant in the workshop.

---

## ✅ Step 1: Verify Your Python Setup

Before running the script, ensure your Python environment is ready.

### 🔍 1. Check Python Version

Run this command in your terminal or command prompt:

```bash
python --version
```

You must have **Python 3.8 or higher**. If not, [download it here](https://www.python.org/downloads/).

> 🧠 Tip: On some systems, `python3 --version` may be required.

### 📦 2. Ensure Required Tools Are Available

Ensure your system includes the following:

| Tool        | Usage                         | How to Install                                                         |
| ----------- | ----------------------------- | ---------------------------------------------------------------------- |
| Python 3.8+ | Runs the local agent script   | [https://www.python.org/downloads/](https://www.python.org/downloads/) |
| Terminal    | Executes CLI commands         | Default on macOS/Linux, use CMD/PowerShell on Windows                  |
| llama-cli   | LLM binary (from `llama.cpp`) | See setup tutorial for your OS                                         |
| GGUF model  | The model used by the AI      | See setup tutorial (e.g., `Q6_K`)                                      |

Check the model file and binary manually:

```bash
ls models/       # Should include: mistral-7b-instruct-v0.1.Q6_K.gguf
ls build/bin/    # Should include: llama-cli or llama-cli.exe
```

---

## 🧠 Step 2: Customize the Python Script

In your `llama.cpp/scripts` folder, you should now place the script below.

```python
# File: local_agent.py
# Purpose: Conversational loop with local LLM (will evolve into code assistant)

import subprocess
import os

# === STUDENTS: MODIFY THESE PATHS FOR YOUR SYSTEM ===
MODEL_PATH = "models/mistral-7b-instruct-v0.1.Q6_K.gguf"       # <-- Update if different
LLAMA_CLI = "build/bin/llama-cli"                              # <-- Use .exe on Windows if needed
MAX_TOKENS = 800

print("\U0001F4DA Fiction Writing Assistant (type 'exit' to quit, 'restart' to repeat the last request, 'clear' to reset story)\n")

history = []  # Keeps track of full interaction

while True:
    user_input = input("\U0001F9D1‍\U0001F4BB You: ").strip()

    if user_input.lower() in ["exit", "quit"]:
        break
    elif user_input.lower() in ["clear", "reset"]:
        history = []
        print("\U0001F9F9 History cleared.")
        continue
    elif user_input.lower() in ["restart", "recommence"]:
        if not history:
            print("\u26A0\uFE0F No previous story to regenerate.")
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
            print("\U0001F916 AI:", ai_response)
            history.append({"user": prompt, "ai": ai_response})
        else:
            print("\U0001F916 AI: (no useful output)")
    except subprocess.CalledProcessError as e:
        print("\u274C Error:", e)
```

---

## 🧪 Next Steps

After this script is running:

- ✅ You know your model and binary are functional
- ✅ You are ready to evolve the agent into a **code-aware assistant**
- ✅ You’ll soon integrate code parsing and editing features

> In the next module, you’ll add logic to analyze `.py` files or full code folders.
