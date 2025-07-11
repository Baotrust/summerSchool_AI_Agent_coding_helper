# 🧠 Local AI Coding Agent — Workshop Primer

This document sets the stage for the workshop. It explains how large language models (LLMs), prompt framing, and local agents can work together to create a **project-specific AI code assistant**.

We focus on:

- 🔧 Practical use of local LLMs (like Mistral)
- 📁 Framing per-project context
- 🧠 Optional fine-tuning later
- 📦 Efficient memory and reasoning via lightweight DB

---

## 🚀 What Are We Building?

An **offline local agent** that:

1. Loads a code project (or workspace)
2. Builds a frame (prompt) from metadata + history
3. Interacts with the developer to:

   - Offer documentation
   - Suggest refactoring
   - Comment the code
   - Spot missing structure or logic

4. Stores its interactions and insights for future sessions

Later:

- That memory can train the model (fine-tune)
- The project evolves — the assistant evolves

---

## 🔍 What's an LLM Really Doing?

> Think of an LLM as **a huge spreadsheet of probabilities**.

When trained, it learns from trillions of examples:

- Programming patterns
- Syntax
- Comments
- File structures

It doesn’t "understand" code like a human does. It:

- Predicts next tokens (text, code)
- Uses patterns it has seen before

But when well-prompted, it behaves like an intelligent collaborator.

---

## 🔁 Prompt Framing vs. Fine-Tuning

| Feature        | Prompt Framing                       | Fine-Tuning                      |
| -------------- | ------------------------------------ | -------------------------------- |
| 📄 What it is  | Instructions + history during run    | Model trained on specific data   |
| ⚙️ When used   | Every time you call the model        | One-time training, re-used often |
| 🔄 Editable?   | Yes, easy to modify live             | No, needs retraining             |
| 🧠 Best for    | Quick tasks, sessions, memory frames | Company/project-style adaptation |
| ⏱️ Time to use | Seconds                              | Hours                            |
| 🔧 Requires    | None (optional DB)                   | Data + compute                   |

---

## 🗂️ Local Agent Flow (With Framing)

```text
User's Dev Folder
│
├── Project A
│   └── src/, docs/, README.md, .git
│
└── Project B
    └── app/, utils/, notes.md
```

1. **User launches the local agent**
2. Agent asks: _"Which project?"_
3. Agent parses:

   - Folder structure
   - Git activity
   - Languages + style

4. DB lookup: _"Have we seen this project before?"_

   - Yes: Load frame
   - No: Ask framing questions

---

## 🧠 What is a Frame?

> A **frame** is a reusable summary of what the AI should focus on.

For example:

```json
{
  "project": "MyApp",
  "type": "Python Flask API",
  "style": "Google docstring format",
  "focus": ["modularization", "comments", "tests"],
  "recent_actions": ["added auth layer"]
}
```

This gets turned into a **prompt** for the model:

```
You are reviewing a Flask API named MyApp.
Use Google-style comments. Focus on test coverage and modular structure.
Recent work: added auth layer.
```

---

## 🛠️ Local Stack Overview

| Component                      | Description                         |
| ------------------------------ | ----------------------------------- |
| `llama.cpp`                    | Engine to run GGUF model (Mistral)  |
| GGUF Model                     | Quantized Mistral 7B (`Q4`, `Q6`)   |
| Python Script                  | Agent logic + conversation loop     |
| Local DB (e.g. TinyDB, SQLite) | Project memory store                |
| (Optional) Online API          | Compare answers (Claude, GPT, etc.) |

---

## 🔍 Advanced: Fine-Tuning Later

If students want to go further, you can fine-tune:

1. Collect full DB logs of conversations
2. Clean + reformat into training pairs
3. Use `QLoRA` or `PEFT` to fine-tune locally or on Colab
4. Swap the base model with the tuned one

---

## ✅ Why This Is Valuable in a Company

- 🧱 Works offline with private code
- 📚 Teaches real-world patterns (Git, linting, docs)
- 🤖 Custom to each developer/project
- 🔐 No copy/paste into ChatGPT = safer

---

## Next Steps in the Workshop

1. Setup LLM locally (Mac, Windows, Linux)
2. Test prompt-based interaction (fiction assistant)
3. Switch to coding-focused agent
4. Add framing & memory per project
5. (Optional) compare to online model evaluation

---

## 🧠 Closing Thoughts

> Reasoning emerges from **context** + **constraints**.

This workshop helps students:

- Control their own tooling
- Think modularly (code, prompts, storage)
- Build ethically aware, helpful agents

We now move to hands-on scripting to shape the actual assistant.
