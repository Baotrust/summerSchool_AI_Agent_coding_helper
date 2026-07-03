# 🐧 Local LLM Setup Guide for Linux (Ubuntu/Debian)

This guide walks you through setting up and running a local Mistral 7B LLM using `llama.cpp` on a Linux system like Ubuntu. This is suitable for students, developers, or anyone interested in using an offline LLM.

---

## 📦 Requirements

- Ubuntu 20.04+ or Debian-based system
- 8+ GB RAM (Q4_K_M minimum), 16+ GB recommended
- Python 3.10+
- Git
- CMake
- Build tools (GCC or Clang, Make or Ninja)

---

## 🚀 1. Clone llama.cpp

```bash
sudo apt update && sudo apt install -y git

# Clone the repo
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp
```

---

## 🛠 2. Install Dependencies and Build

Install CMake and build tools:

```bash
sudo apt install -y cmake build-essential
```

Then compile llama.cpp:

```bash
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . --config Release
```

✅ The binary will be located at:

```bash
./build/bin/llama-cli
```

---

## 📦 3. Download the Model (Mistral 7B Instruct)

1. Open your browser and visit:

   👉 [https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.3-GGUF](https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.3-GGUF)

2. Download a file like:

   `mistral-7b-instruct-v0.3.Q6_K.gguf`

3. Return to your project root and move the file:

```bash
cd ~/path/to/llama.cpp  # adjust as needed
mkdir -p models
mv ~/Downloads/mistral-7b-instruct-v0.3.Q6_K.gguf models/
```

---

## 🧪 4. Run a Basic Prompt

```bash
./build/bin/llama-cli \
  -m models/mistral-7b-instruct-v0.3.Q6_K.gguf \
  -p "Write a short poem about the ocean." \
  -n 300
```

✅ The terminal will output a response inline.

---

## 🧰 5. Optional Python Wrapper

For an interactive session, create a Python script using `subprocess` to call the model.

---

## 💡 Notes

- Tested on Ubuntu 22.04 LTS
- ARM or x86 architectures supported
- Performance depends on quantization level (Q4_K_M/Q5_K_M/Q6_K/Q8_K_M)

---

## ✅ Summary

You are now ready to:

- Run local prompts with `llama-cli`
- Extend your setup for Python agents or CLI tools
- Prepare for integration in local code workflows

---

For advanced usage (agents, Docker, VS Code integration), see accompanying tutorials.
