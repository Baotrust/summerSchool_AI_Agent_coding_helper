# 🪟 Local LLM Setup Guide for Windows

This guide helps students set up and run a local LLM (like Mistral) on Windows using `llama.cpp`. It's optimized for pre-course preparation.

---

## 📦 Requirements

- Windows 10 or 11 (64-bit)
- 8+ GB RAM (16+ recommended)
- Python 3.10+
- Git
- Optional: CUDA-compatible GPU (for better performance)

---

## 🔧 Option 1: Pre-built `llama.cpp` Binaries (Recommended)

1. **Download Prebuilt llama.cpp**

   - Visit: [https://github.com/ggerganov/llama.cpp/releases](https://github.com/ggerganov/llama.cpp/releases)
   - Download latest `llama-win64.exe` or `llama-server.exe`

2. **Get a GGUF Model**

   - Visit: [https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF](https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF)
   - Download: `mistral-7b-instruct-v0.1.Q4_K_M.gguf`
   - Place it next to the executable

3. **Run**

   ```sh
   ./llama-win64.exe -m mistral-7b-instruct-v0.1.Q4_K_M.gguf -p "What is local AI?"
   ```

---

## ⚙️ Option 2: Build from Source (Advanced)

1. **Install MSYS2 or CMake**

   ```sh
   winget install --id Git.Git
   winget install --id Kitware.CMake
   winget install --id Ninja-build
   ```

2. **Clone llama.cpp**

   ```sh
   git clone https://github.com/ggerganov/llama.cpp
   cd llama.cpp
   ```

3. **Build**

   ```sh
   cmake -B build -G Ninja .
   cmake --build build --config Release
   ```

4. **Run the CLI**

   ```sh
   ./build/bin/llama-cli.exe -m path/to/model.gguf -p "Hello world"
   ```

---

## 🌐 Option 3: Run `llama-server.exe` (Web Interface)

1. Download `llama-server.exe` from GitHub releases
2. Drop your `.gguf` model in same folder
3. Launch the server:

   ```sh
   ./llama-server.exe -m model.gguf
   ```

4. Open browser: [http://localhost:8080](http://localhost:8080)

---

## 🎥 Video Guide

YouTube (Step-by-step for Windows):

- [https://www.youtube.com/watch?v=UkVDlpv8vcc](https://www.youtube.com/watch?v=UkVDlpv8vcc)

---

## 🔍 More Guides

- SteelPh0enix full guide: [https://steelph0enix.github.io/posts/llama-cpp-guide](https://steelph0enix.github.io/posts/llama-cpp-guide)
- Reddit quick start: [https://www.reddit.com/r/LocalLLaMA/comments/18d7py9](https://www.reddit.com/r/LocalLLaMA/comments/18d7py9)

---

## ✅ Ready to Use

Once installed, students will be able to:

- Run prompts via CLI
- Connect the agent to their project folder
- Interact with code files locally and privately

---

For any issues, bring your machine to the workshop lab session.
