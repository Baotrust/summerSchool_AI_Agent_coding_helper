# 🧠 Local AI Code Agent — Full-Day Workshop

## 📅 Purpose

This full-day hands-on workshop introduces students to building and deploying a **local AI coding assistant**. The session covers the **architecture, tools, ethical framing**, and implementation of a personal AI agent capable of understanding and improving software projects — entirely **offline**, with optional **remote model evaluations**.

It’s designed to give participants a deep understanding of:

- The AI agent ecosystem
- Open-source LLMs (e.g. Mistral)
- Prompt engineering
- Offline-first workflows
- Real-world software augmentation

---

## 🕘 Morning — Foundations & Framing

### 1. 🧭 Introduction to AI Agents & Mistral

- What are AI agents?
- The Mistral ecosystem and open models
- Use cases: insurance, health, travel, enterprise automation
- Overview of `llama.cpp` and quantized model formats (GGUF)

### 2. 🔍 Choosing the Right LLM for the Job

- How to evaluate models for local execution
- RAM, architecture, and quantization (Q4_K, Q6_K, Q8_0…)
- When to offload to remote APIs (GPT-4, Claude, Codestral)
- Comparison platforms: Hugging Face, Google Colab, etc.

### 3. 🎯 Prompt Engineering

- How prompts drive behavior
- Instruction-tuned models vs. base models
- Techniques: zero-shot, few-shot, role conditioning

### 4. ⚖️ Ethics & Risks of Local AI

- What’s private, what’s shared
- Legal risks of training on corporate code
- Understanding hallucination vs. transformation
- Transparency and logging of agent contributions

---

## 🔧 Afternoon — Workshop & Build

### 👨‍💻 Hands-On Objective

Build a **local AI code assistant** that can:

- Review and summarize source code
- Suggest improvements and generate comments/docstrings
- Help write or correct README files
- Run completely offline with Mistral
- Optionally evaluate its answers using online APIs

---

## ✨ Key Features You’ll Build

- 🧱 **Local LLM** (Mistral-7B in GGUF) via `llama.cpp`
- 🔍 **Context-aware project parsing**
- 📁 **Per-project prompt memory** (optional: use a database)
- 🧠 **Code quality suggestions** (refactoring, naming, doc)
- 🛠️ **Modular CLI agent** usable in Neovim or any terminal
- 🌐 **Optional: Remote evaluation fallback via APIs**
- 📊 **Evaluation logs for quality improvement**

---

## 🏗️ Architecture Summary

```text
Student Codebase
       │
       ▼
[ Local Agent ]
(llama.cpp + prompt loader + CLI)
       │
       ├──> Parses project structure and content
       ├──> Builds prompts using history or memory
       ├──> Runs prompt through local LLM
       ├──> Shows results and suggestions in terminal
       │
       ├── (Optional) Query remote model for review
       └── (Optional) Update memory/prompt templates
```

---

## 🧰 APIs & Tools Used

| Purpose              | Tool / API                                    | Description                                |
|----------------------|-----------------------------------------------|--------------------------------------------|
| Local inference      | `llama.cpp`, Mistral GGUF                     | Local LLM execution engine                 |
| Model comparison     | Hugging Face, Colab                           | Benchmark, explore quantization            |
| Syntax parsing       | [tree-sitter](https://tree-sitter.github.io/) | Detect and classify code structures        |
| Git integration      | `gitpython`, Git CLI                          | Code history, blame, diffs                 |
| Remote eval (opt.)   | GPT-4, Claude, Codestral                      | Compare suggestions or get scoring         |
| Agent packaging      | `.pyz`, Docker                                | Portable deployment setups                 |
| Optional memory      | ChromaDB, JSON store                          | Frame-based prompts or long-term memory    |

---

## 📦 Portability

- Works on **macOS, Windows, Linux**
- Runs with **Python 3.10+**
- Requires only CLI tools and local binaries
- Deployable via:
  - `.pyz` Python archive
  - Docker container
  - System-level CLI tool

---

## ✅ Workshop Outcomes

By the end of the day, students will:

- Understand how LLMs operate in offline environments
- Use a **Mistral-based code assistant** on their own machine
- Know how to shape prompts and integrate agent tools
- Compare local and remote model output critically
- Be aware of **best practices, ethics, and limitations**

---

## 🧪 Optional Extension (If Time Permits)

- Add a per-project memory system (lightweight DB or prompt templates)
- Try evaluation loops using Claude or GPT-4
- Refactor or document a full microservice with the agent

---

## 📚 Prerequisites

- Python 3.10+ installed
- Terminal experience (Linux/macOS/Windows)
- Git CLI familiarity
- A codebase in Python, JS, or Java to test on
- Downloaded and compiled `llama.cpp`
- Mistral GGUF model downloaded (Q6_K or Q8_K)

---

## 💬 Suggested Practice Projects

| Task                                | Language  | Description                                      |
|-------------------------------------|-----------|--------------------------------------------------|
| Refactor CLI tool                   | Python    | Improve naming, modularity                       |
| Add docstrings and README.md        | JavaScript| Comment poorly documented components             |
| Evaluate Git commit quality         | Any       | Agent checks for semantic commits and patterns   |
| Design refactor proposal            | Java      | Convert legacy file structure to new pattern     |
| Prompt-test your own agent          | Mixed     | Test multiple phrasing strategies                |

---

## 🎓 Designed For

- CS Master’s students
- AI & Software Engineering bootcamps
- Developer advocacy teams exploring AI tooling
- AI ethics or human-in-the-loop courses

---

## 🧠 Why Local?

> Because private code should stay private — and **offline agents** let you benefit from AI without leaking your IP, exposing user data, or relying on external APIs.

---