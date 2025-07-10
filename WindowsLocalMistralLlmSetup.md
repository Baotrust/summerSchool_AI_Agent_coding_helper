# 🪟 Local Mistral LLM Setup Guide for Windows

This guide walks you through setting up and running a local **Mistral 7B Instruct** model using `llama.cpp` on **Windows**. Ideal for developers, students, and workshops involving local AI agents.

---

## 🚀 1. Clone llama.cpp

```powershell
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp
```

---

## 🛠 2. Build with CMake (Windows)

Install required tools:

```powershell
winget install --id Git.Git -e
winget install --id Kitware.CMake -e
winget install --id Ninja-build -e
```

Then build llama.cpp:

```powershell
mkdir build
cd build
cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build . --config Release
```

✅ Binary output will be in:

```powershell
./build/bin/llama-cli.exe
```

---

## 📦 3. Download the Model (Mistral 7B Instruct)

1. Open your browser and go to:

   👉 [https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF](https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF)

2. Download the model file:

   - Recommended version: `mistral-7b-instruct-v0.1.Q6_K.gguf`

3. In your terminal, navigate to the `llama.cpp` root directory:

```powershell
cd path\to\llama.cpp
```

4. Create the `models` folder if not already present:

```powershell
mkdir models
```

5. Move the model file to `models/`:

```powershell
move "C:\Users\<YourUser>\Downloads\mistral-7b-instruct-v0.1.Q6_K.gguf" models\
```

📁 Final directory structure should look like:

```
llama.cpp\
├── build\
│   └── bin\
│       └── llama-cli.exe
├── models\
    └── mistral-7b-instruct-v0.1.Q6_K.gguf
```

---

## 🧪 4. Run a Basic Prompt

Test your setup with:

```powershell
./build/bin/llama-cli.exe ^
  -m models/mistral-7b-instruct-v0.1.Q6_K.gguf ^
  -p "Write a short story about a mysterious cabin in the woods." ^
  -n 300
```

✅ You should see a story printed in your terminal.

---

## 🧰 5. Interactive Python CLI Script

Use this script to run an AI agent with memory and conversation control:

```python
# File: scripts/converse-local.py
# Launches a local assistant via llama-cli.exe
```

Features:

- Accepts user prompts
- Tracks conversation history
- Supports `restart`, `clear`, and `exit`
- Executes via `subprocess`

Ensure the paths to the model and executable match your environment.

---

## 💡 Hardware Notes

- ✅ Works on Windows 10/11 (64-bit)
- ✅ Recommended: 16+ GB RAM
- Minimum: 8 GB RAM (Q4 or Q6 quantized models)

---

## ✅ Summary

You're now ready to:

- Run Mistral 7B fully offline
- Use it for local assistants, code review, and documentation agents
- Extend into more advanced projects using Python or CLI

---

For issues, bring your setup to the workshop lab session or refer to:

- GitHub Issues: [https://github.com/ggerganov/llama.cpp/issues](https://github.com/ggerganov/llama.cpp/issues)
- Windows CLI guide: [https://steelph0enix.github.io/posts/llama-cpp-guide](https://steelph0enix.github.io/posts/llama-cpp-guide)
