# Install llama.cpp

This short tutorial installs the `llama.cpp` engine used by the workshop.

The model files stay outside the engine repo:

```text
~/development/AI-models/llm/
```

The engine is installed here:

```text
~/development/llama.cpp-stable/
```

Official build reference:

```text
https://github.com/ggml-org/llama.cpp/blob/master/docs/build.md
```

## 1. Install Build Tools

### macOS

Install Xcode command line tools and CMake:

```bash
xcode-select --install
brew install cmake git
```

On Apple Silicon, Metal GPU support is enabled by default in current `llama.cpp` builds.

### Ubuntu or Debian Linux

```bash
sudo apt update
sudo apt install -y git cmake build-essential
```

### Windows

Install these tools from PowerShell:

```powershell
winget install --id Git.Git -e
winget install --id Kitware.CMake -e
winget install --id Ninja-build.Ninja -e
```

After installing them, close and reopen PowerShell so the new commands are on your `PATH`.

## 2. Clone llama.cpp

### macOS and Linux

```bash
mkdir -p ~/development
cd ~/development
git clone https://github.com/ggml-org/llama.cpp llama.cpp-stable
cd llama.cpp-stable
```

### Windows PowerShell

```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\development"
Set-Location "$env:USERPROFILE\development"
git clone https://github.com/ggml-org/llama.cpp llama.cpp-stable
Set-Location "$env:USERPROFILE\development\llama.cpp-stable"
```

## 3. Build llama.cpp

### macOS and Linux

```bash
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
```

Expected binary:

```text
~/development/llama.cpp-stable/build/bin/llama-cli
```

### Windows PowerShell

```powershell
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
```

Expected binary:

```text
%USERPROFILE%\development\llama.cpp-stable\build\bin\llama-cli.exe
```

## 4. Test the Install

Make sure the Mistral GGUF model has already been downloaded using [00-BeforeCoursePrep-Models.md](./00-BeforeCoursePrep-Models.md).

### macOS and Linux

```bash
cd ~/development/llama.cpp-stable
build/bin/llama-cli \
  -m ~/development/AI-models/llm/Mistral-7B-Instruct-v0.3-Q6_K.gguf \
  -p "Say hello in one sentence." \
  -n 40 \
  --single-turn
```

If you downloaded the smaller model, replace the model filename with:

```text
Mistral-7B-Instruct-v0.3-Q4_K_M.gguf
```

### Windows PowerShell

```powershell
Set-Location "$env:USERPROFILE\development\llama.cpp-stable"
.\build\bin\llama-cli.exe `
  -m "$env:USERPROFILE\development\AI-models\llm\Mistral-7B-Instruct-v0.3-Q6_K.gguf" `
  -p "Say hello in one sentence." `
  -n 40 `
  --single-turn
```

If you downloaded the smaller model, replace the model filename with:

```text
Mistral-7B-Instruct-v0.3-Q4_K_M.gguf
```

## 5. Run the Course Script

After the binary and model are in place, use the workshop wrapper script:

```bash
cd ~/development/llmWorkshopSummerSchool
./run_local_mistral.sh once "Say hello."
```

Terminal chat:

```bash
./run_local_mistral.sh chat
```

Web UI:

```bash
./run_local_mistral.sh web
```

## Troubleshooting

If `cmake` is not found, reopen your terminal after installing it.

If the test says the model file is missing, finish [00-BeforeCoursePrep-Models.md](./00-BeforeCoursePrep-Models.md) first.

If the build succeeds but `llama-cli` is not in `build/bin/`, search for it:

### macOS and Linux

```bash
find ~/development/llama.cpp-stable/build -name "llama-cli*"
```

### Windows PowerShell

```powershell
Get-ChildItem "$env:USERPROFILE\development\llama.cpp-stable\build" -Recurse -Filter "llama-cli*"
```
