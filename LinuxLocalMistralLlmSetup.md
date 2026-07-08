# 🐧 Local LLM Setup Guide for Linux (Ubuntu/Debian)

This page is a legacy OS note. The authoritative before-course model prep is in [00-BeforeCoursePrep-Models.md](./00-BeforeCoursePrep-Models.md) and the course runtime script is [run_local_mistral.sh](./run_local_mistral.sh).

---

## 📦 Requirements

- Ubuntu 20.04+ or Debian-based system
- 8+ GB RAM (Q4_K_M minimum), 16+ GB recommended
- Python 3.10+
- Git
- CMake
- Build tools (GCC or Clang, Make or Ninja)

---

## 🚀 1. Clone the Stable Repo

```bash
sudo apt update && sudo apt install -y git

# Clone the repo
git clone https://github.com/ggml-org/llama.cpp llama.cpp-stable
cd llama.cpp-stable
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

## 📦 3. Model Location

The course model now lives outside the engine repo:

```bash
~/development/AI-models/llm/Mistral-7B-Instruct-v0.3-Q6_K.gguf
```

If your machine is small, use `Mistral-7B-Instruct-v0.3-Q4_K_M.gguf` instead.

The download link is documented in [00-BeforeCoursePrep-Models.md](./00-BeforeCoursePrep-Models.md).

---

## 🧪 4. Run a Basic Prompt

```bash
./build/bin/llama-cli \
  -m ~/development/AI-models/llm/Mistral-7B-Instruct-v0.3-Q6_K.gguf \
  -p "Write a short poem about the ocean." \
  -n 300 \
  --single-turn
```
