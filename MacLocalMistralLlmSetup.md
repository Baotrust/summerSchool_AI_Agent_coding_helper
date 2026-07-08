# 🧠 Local Mistral LLM Setup Guide (macOS)

This page is a legacy OS note. The authoritative before-course model prep is in [00-BeforeCoursePrep-Models.md](./00-BeforeCoursePrep-Models.md) and the course runtime script is [run_local_mistral.sh](./run_local_mistral.sh).

---

## 🚀 1. Clone the Stable Repo

```bash
git clone https://github.com/ggml-org/llama.cpp llama.cpp-stable
cd llama.cpp-stable
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

## 📦 3. Model Location

The course model now lives outside the engine repo:

```bash
~/development/AI-models/llm/Mistral-7B-Instruct-v0.3-Q6_K.gguf
```

If you are on a smaller Mac, use `Mistral-7B-Instruct-v0.3-Q4_K_M.gguf` instead.

The download link is documented in [00-BeforeCoursePrep-Models.md](./00-BeforeCoursePrep-Models.md).

---

## 🧪 4. Run a Basic Prompt

```bash
./build/bin/llama-cli \
  -m ~/development/AI-models/llm/Mistral-7B-Instruct-v0.3-Q6_K.gguf \
  -p "Say hello." \
  -n 50 \
  --single-turn
```

---
