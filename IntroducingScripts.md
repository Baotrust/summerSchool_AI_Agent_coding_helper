# 🤪 Getting Started with Your Local AI Agent

This tutorial guides you through verifying your Python environment and preparing to run your local AI agent script (`local_agent.py`). This script will serve as the base for an intelligent coding assistant in the workshop.

---

## ✅ Step 1: Verify Your Python Setup

Before running the script, ensure your Python environment is ready.

### 🔍 1. Check Python Version

Run this command in your terminal or command prompt:

```bash
python --version
```

You must have **Python 3.10 or higher**. If not, [download it here](https://www.python.org/downloads/).

> 🧠 Tip: On some systems, `python3 --version` may be required.

### 📦 2. Ensure Required Tools Are Available

Ensure your system includes the following:

| Tool        | Usage                         | How to Install                                                         |
| ----------- | ----------------------------- | ---------------------------------------------------------------------- |
| Python 3.10+ | Runs the local agent script   | [https://www.python.org/downloads/](https://www.python.org/downloads/) |
| Terminal    | Executes CLI commands         | Default on macOS/Linux, use CMD/PowerShell on Windows                  |
| llama-cli   | LLM binary (from `llama.cpp`) | See setup tutorial for your OS                                         |
| GGUF model  | The model used by the AI      | See setup tutorial (e.g., `Q5_K_M` or `Q6_K`)                          |

Check the model file and binary manually:

```bash
ls models/       # Should include: mistral-7b-instruct-v0.3.Q6_K.gguf
ls build/bin/    # Should include: llama-cli or llama-cli.exe
```

---

## 🧠 Step 2: Customize the Python Script

In your `llama.cpp/scripts` folder, you should now place the script below.

```python
# File: local_agent.py
# Purpose: Minimal loop with local LLM (used to verify setup)

import subprocess
import os

# === STUDENTS: MODIFY THESE PATHS FOR YOUR SYSTEM ===
MODEL_PATH = "models/mistral-7b-instruct-v0.3.Q6_K.gguf"       # <-- Update if different
LLAMA_CLI = "build/bin/llama-cli"                              # <-- Use .exe on Windows if needed
MAX_TOKENS = 800

print("\U0001F4DA Local AI Agent Ready — type 'exit' to quit\n")

while True:
    user_input = input("\U0001F9D1‍\U0001F4BB You: ").strip()

    if user_input.lower() in ["exit", "quit"]:
        break

    prompt = f"You: {user_input}\nAI:"

    cmd = [
        LLAMA_CLI,
        "-m", MODEL_PATH,
        "-p", prompt,
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
        else:
            print("\U0001F916 AI: (no useful output)")
    except subprocess.CalledProcessError as e:
        print("❌ Error:", e)
```

> ⚠️ **Note on Model Behavior**:
>
> At this stage, the model may appear to **echo your prompt** or generate **unrelated content**. This is normal — it stems from the fact that we haven't yet framed its behavior or provided system-level instructions.
>
> You'll improve this by:
>
> - Structuring prompt templates (with `You:` and `AI:` tags)
> - Adding memory or project-specific context
> - Injecting guardrails in the logic

---

## 🧹 Improving Code Consistency with Python Bindings

> **Why Switch from Subprocess to `llama-cpp-python`?**
>
> The initial setup using `subprocess` and `llama-cli` was useful to quickly validate model inference, but it introduces several drawbacks:
>
> - ❌ **Inconsistent behavior**: Repeated prompts or hallucinated responses can happen because of improper prompt framing and loss of session context.
> - ❌ **Limited control**: It's harder to set system prompts, manage conversation context, or handle advanced features like token streaming.
> - ❌ **Less efficient**: Spawning a subprocess for each interaction increases latency.
>
> ✅ **Switching to `llama-cpp-python` solves these issues** by allowing direct interaction with the model in Python:
>
> - 🟢 **Session-level control**: Keep context alive inside Python with configurable context length.
> - 🟢 **Cleaner outputs**: Less formatting noise, no prompt echo by default.
> - 🟢 **Streamlined codebase**: More maintainable code with less shell interaction overhead.
> - 🟢 **Better educational value**: Students can directly explore AI inference logic in Python.
>
> ✅ **How to Install for All OS (Windows/macOS/Linux):**
>
> Depending on your setup:
>
> - **With virtual environment**:
>
> ```bash
> python3 -m venv venv
> source venv/bin/activate  # On Windows: venv\Scripts\activate
> pip install llama-cpp-python
> ```
>
> - **Or globally if you prefer**:
>
> ```bash
> pip install --user llama-cpp-python
> ```
>
> ✅ **Example Code Structure**:
>
> ```python
> from llama_cpp import Llama
>
> MODEL_PATH = "models/mistral-7b-instruct-v0.3.Q6_K.gguf"
> llama = Llama(model_path=MODEL_PATH, n_ctx=4096)
>
> while True:
>     user_input = input("🧑‍💻 You: ").strip()
>     if user_input.lower() in ["exit", "quit"]:
>         break
>     response = llama(user_input, max_tokens=300)
>     print("🤖 AI:", response["choices"][0]["text"].strip())
> ```
>
> ✅ **Summary**:
>
> Switching to `llama-cpp-python` ensures better reproducibility, easier debugging, and a smoother learning experience during the workshop.
