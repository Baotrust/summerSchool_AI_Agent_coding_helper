# 🪟 Local Mistral LLM Setup Guide for Windows

This page is a legacy OS note. The authoritative before-course model prep is in [00-BeforeCoursePrep-Models.md](./00-BeforeCoursePrep-Models.md) and the course runtime script is [run_local_mistral.sh](./run_local_mistral.sh).

---

## 🚀 1. Clone the Stable Repo

```powershell
git clone https://github.com/ggml-org/llama.cpp llama.cpp-stable
cd llama.cpp-stable
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

## 📦 3. Model Location

The course model now lives outside the engine repo:

```text
%USERPROFILE%\development\AI-models\llm\Mistral-7B-Instruct-v0.3-Q6_K.gguf
```

If your machine is tight on memory, use `Mistral-7B-Instruct-v0.3-Q4_K_M.gguf` instead.

The download link is documented in [00-BeforeCoursePrep-Models.md](./00-BeforeCoursePrep-Models.md).

---

## 🧪 4. Run a Basic Prompt

Test your setup with:

```powershell
.\build\bin\llama-cli.exe ^
  -m "$env:USERPROFILE\development\AI-models\llm\Mistral-7B-Instruct-v0.3-Q6_K.gguf" ^
  -p "Write a short story about a mysterious cabin in the woods." ^
  -n 300 ^
  --single-turn
```

---
