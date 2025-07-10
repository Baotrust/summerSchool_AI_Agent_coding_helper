# 🧠 Local AI Code Agent Workshop

## Overview

This hands-on workshop introduces students to building and deploying a **local AI code assistant**, capable of reviewing and improving software projects without relying on cloud APIs. The agent is designed to run fully offline, with optional remote model augmentation and evaluation tools.

---

## ✨ Goals

- Introduce AI agents for code review and documentation
- Empower students with open, transparent tooling
- Enable private and portable code intelligence workflows
- Explore hybrid AI setups: local LLMs + remote evaluations
- Raise awareness of ethical and legal implications

---

## 🔧 Key Features

- **Local LLM (e.g. Mistral-7B GGUF format)** using `llama.cpp`
- **Multi-file project analysis**: understands full codebases
- **Neovim-compatible** CLI tool (or adaptable to any IDE)
- **Code commenting and docstring generation**
- **README suggestions and refactoring prompts**
- **Offline-capable**, private-by-default architecture
- **Optional remote API fallback** (Claude, GPT-4, Codestral)
- **Evaluation agent**: uses online models to benchmark/help improve the local one

---

## 🏗️ Architecture

```text
Student Codebase
       │
       ▼
[ Local Agent ]
(llama.cpp + context loader + CLI)
       │
       ├──> Parses project, builds prompt context
       ├──> Calls local Mistral model
       ├──> Generates file-level suggestions
       ├──> CLI displays/editable output
       │
       ├── (Optional) Query remote model for evaluation
       └── (Optional) Use response as quality feedback---
```

## 🔌 Useful APIs and Tools

| Purpose              | API / Tool                                    | Description                                |
| -------------------- | --------------------------------------------- | ------------------------------------------ |
| Code Analysis        | [tree-sitter](https://tree-sitter.github.io/) | Parse syntax trees of multiple languages   |
| Git Integration      | `gitpython`, Git CLI                          | Extract commit history, blame, diffs       |
| AI Evaluation        | OpenAI, Anthropic, Codestral                  | Remote model access for quality evaluation |
| Deployment           | `pyz`, Docker                                 | Portable, local agent export               |
| Model Hosting        | Ollama, llama.cpp                             | Run Mistral GGUF on-device                 |
| README Checker       | `readme-md-generator`, Markdown Linter        | Optional for documentation health          |
| Vector DB (optional) | Chroma, Weaviate                              | Persistent memory for long-term agents     |

---

## 📦 Portability

- **`.pyz` (Python zip)**: single file binary, quick deployment
- **Docker image**: host the model and tools together
- **Volume-mapped project folder**: the agent runs in any containerized dev environment

---

## 🔐 Ethics & Legal

Students will learn to:

- Distinguish between **offline** vs **cloud-based** AI risks
- Avoid **accidental data leaks** with private repos
- Respect **licensing** and **proprietary code usage**
- Apply **responsible AI usage**: no code generation without understanding
- Document AI usage clearly in READMEs or commits

---

## 🧪 Optional Evaluation Loop

A secondary agent can:

1. Re-read the local model’s answers
2. Send them to a remote model (Claude, GPT-4, Codestral)
3. Get evaluation/feedback
4. Log results and fine-tune prompts or config

This turns the workshop into a **research-grounded workflow**, encouraging critical thinking and iteration.

---

## 💡 Suggested Project Topics

- Refactor a Python microservice using the agent
- Comment a JavaScript repo and generate a README
- Compare GPT-4 vs Mistral on a specific file
- Evaluate code quality across commits using Git hooks
- Build your own prompt-engineered CLI for reviewing

---

## 📚 Requirements

- macOS/Linux/Windows (8GB+ RAM recommended)
- Python 3.10+
- `llama.cpp` compiled for local Mistral model
- Git-enabled code project (Python, JS, Java…)

---

## 🏁 Outcome

By the end of this 3-hour lab, students will have:

- A working **local AI code agent**
- Insight into how **context, prompt design, and models interact**
- A deployable script or container for future codebases
- Experience evaluating **offline vs online LLMs**
- Awareness of **AI ethics** and data privacy
