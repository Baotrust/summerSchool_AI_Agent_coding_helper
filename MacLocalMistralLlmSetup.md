# 🧠 Local Mistral LLM Setup Guide (with `llama.cpp`)

This guide walks you through setting up and running a local Mistral model (7B) using `llama.cpp` on macOS. Ideal for developers, students, and workshops involving local AI agents.

---

## 🚀 1. Clone llama.cpp

```bash
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp
```

---

## 🛠 2. Build with Apple Silicon (Metal)

Compile using **CMake with Metal support** (recommended for M1/M2/M3 Macs):

```bash
brew install cmake
mkdir build && cd build
cmake .. -DGGML_METAL=on
cmake --build . --config Release
```

✅ Binary output will be in:

```bash
./build/bin/llama-cli
```

---

## 📦 3. Download the Model (Mistral 7B Instruct)

1. Open your browser and go to:

   👉 [https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF](https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF)

2. Download the model file:

   - Recommended version: `mistral-7b-instruct-v0.1.Q6_K.gguf`

3. In your terminal, go to the root of your `llama.cpp` project directory:

```bash
cd path/to/your/llama.cpp
```

4. Ensure the `models/` directory exists:

```bash
mkdir -p models
```

---

5. Move the downloaded file to the correct location:

```bash
mv ~/Downloads/mistral-7b-instruct-v0.1.Q6_K.gguf models/
```

📅 Final directory structure should look like:

```
llama.cpp/
├── build/
│   └── ...
├── models/
    └── mistral-7b-instruct-v0.1.Q6_K.gguf
```

---

You can now test your setup by running (from the project root):

```bash
./build/bin/llama-cli -m models/mistral-7b-instruct-v0.1.Q6_K.gguf -p "Say hello." -n 50
```

---

## 🧪 4. Run a Basic Prompt

Use the `llama-cli` to generate a simple response:

```bash
./build/bin/llama-cli \
  -m models/mistral-7b-instruct-v0.1.Q6_K.gguf \
  -p "Write a short story about a mysterious cabin in the woods." \
  -n 300
```

✅ You should see a story generated inline in your terminal.

---

## 🧰 5. Interactive Python CLI Script

Use a script to run an AI agent with history and conversation control:

```python
# File: converse-local.py
# Launches a terminal-based fiction-writing assistant powered by local LLM
```

This script:

- Accepts user prompts
- Stores history of exchanges
- Supports `restart`, `clear`, and `exit` commands
- Sends prompt via `subprocess` to `llama-cli`

Make sure to adjust the paths to your model and binary accordingly.

---

## 💡 Hardware Notes

- ✅ Tested on **MacBook Pro M3 Max, 48 GB unified memory**
- ✅ Works best with **Metal GPU offloading**
- Minimum: 8–16 GB RAM (Q4_0 or Q6_K models)

---

## ✅ Summary

You're now ready to:

- Run a local LLM fully offline
- Use it in CLI-based agents
- Extend for project-based reasoning (refactoring, documentation, etc.)

---

For further integration with agents or IDEs, see advanced tutorials or Docker setup.
