# Before Course Prep - Local Models

Complete this before the workshop.

The course uses two local AI stacks:

| Stack | What it does | Engine | Model folder |
|---|---|---|---|
| Local LLM | Text assistant and coding agent | `llama.cpp` | `~/development/AI-models/llm/` |
| Local image generation | ComfyUI workflows and image templates | `ComfyUI` | `~/development/AI-models/comfyui/` |

The model files are large. Downloading them before class avoids losing workshop time.

## 1. Check Your Machine

Use the section that matches your operating system.

### macOS

```bash
uname -m
sysctl hw.memsize
```

Interpretation:

| Result | Meaning | Recommended LLM |
|---|---|---|
| `arm64` with 16 GB RAM or more | Apple Silicon M1/M2/M3/M4 | `Mistral-7B-Instruct-v0.3-Q6_K.gguf` |
| `arm64` with 8 GB RAM | Apple Silicon, smaller memory | Prefer `Q4_K_M` if `Q6_K` is too slow |
| `x86_64` | Intel Mac | Prefer `Q4_K_M` or use the course machine |

ComfyUI image generation is heavier than text generation. Apple Silicon with 16 GB or more is strongly preferred.

### Windows

Open PowerShell:

```powershell
wmic os get OSArchitecture
Get-CimInstance Win32_ComputerSystem | Select-Object TotalPhysicalMemory
```

Interpretation:

| Machine | Recommended LLM | Notes |
|---|---|---|
| Windows x64, 16 GB RAM or more | `Q6_K` | Good workshop baseline |
| Windows x64, 8-12 GB RAM | `Q4_K_M` | Smaller and more forgiving |
| NVIDIA GPU available | Same GGUF model | GPU affects speed, not the model folder layout |

### Linux

```bash
uname -m
free -h
nvidia-smi 2>/dev/null || true
```

Interpretation:

| Machine | Recommended LLM | Notes |
|---|---|---|
| `x86_64`, 16 GB RAM or more | `Q6_K` | Good workshop baseline |
| `x86_64`, 8-12 GB RAM | `Q4_K_M` | Smaller and more forgiving |
| NVIDIA GPU available | Same GGUF model | GPU affects build/runtime flags |
| ARM Linux | Ask before class | Model may work, but setup varies more |

## 2. Choose the LLM Quantization

Use this decision rule:

| Available RAM | Download |
|---|---|
| 16 GB or more | `Mistral-7B-Instruct-v0.3-Q6_K.gguf` |
| 8-12 GB | `Mistral-7B-Instruct-v0.3-Q4_K_M.gguf` |
| Less than 8 GB | Use a course machine or ask before class |

The reference setup uses `Q6_K`. It is a good balance for modern Macs and 16 GB student machines.

## 3. Create the Shared Model Folders

### macOS and Linux

```bash
mkdir -p ~/development/AI-models/llm
mkdir -p ~/development/AI-models/comfyui/checkpoints
mkdir -p ~/development/AI-models/comfyui/vae
mkdir -p ~/development/AI-models/comfyui/loras
mkdir -p ~/development/AI-models/comfyui/upscale_models
mkdir -p ~/development/AI-models/comfyui/clip_vision
mkdir -p ~/development/AI-models/comfyui/ipadapter
mkdir -p ~/development/AI-models/comfyui/sams
mkdir -p ~/development/AI-models/comfyui/ultralytics
```

### Windows PowerShell

```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\development\AI-models\llm"
New-Item -ItemType Directory -Force "$env:USERPROFILE\development\AI-models\comfyui\checkpoints"
New-Item -ItemType Directory -Force "$env:USERPROFILE\development\AI-models\comfyui\vae"
New-Item -ItemType Directory -Force "$env:USERPROFILE\development\AI-models\comfyui\loras"
New-Item -ItemType Directory -Force "$env:USERPROFILE\development\AI-models\comfyui\upscale_models"
New-Item -ItemType Directory -Force "$env:USERPROFILE\development\AI-models\comfyui\clip_vision"
New-Item -ItemType Directory -Force "$env:USERPROFILE\development\AI-models\comfyui\ipadapter"
New-Item -ItemType Directory -Force "$env:USERPROFILE\development\AI-models\comfyui\sams"
New-Item -ItemType Directory -Force "$env:USERPROFILE\development\AI-models\comfyui\ultralytics"
```

## 4. Download the LLM Model

Use one of these. Download only one unless instructed otherwise.

### Recommended: 16 GB RAM or More

macOS and Linux:

```bash
curl -L --fail --continue-at - \
  --output ~/development/AI-models/llm/Mistral-7B-Instruct-v0.3-Q6_K.gguf \
  https://huggingface.co/bartowski/Mistral-7B-Instruct-v0.3-GGUF/resolve/main/Mistral-7B-Instruct-v0.3-Q6_K.gguf
```

Windows PowerShell:

```powershell
Invoke-WebRequest `
  -Uri "https://huggingface.co/bartowski/Mistral-7B-Instruct-v0.3-GGUF/resolve/main/Mistral-7B-Instruct-v0.3-Q6_K.gguf" `
  -OutFile "$env:USERPROFILE\development\AI-models\llm\Mistral-7B-Instruct-v0.3-Q6_K.gguf"
```

### Smaller Fallback: 8-12 GB RAM

macOS and Linux:

```bash
curl -L --fail --continue-at - \
  --output ~/development/AI-models/llm/Mistral-7B-Instruct-v0.3-Q4_K_M.gguf \
  https://huggingface.co/bartowski/Mistral-7B-Instruct-v0.3-GGUF/resolve/main/Mistral-7B-Instruct-v0.3-Q4_K_M.gguf
```

Windows PowerShell:

```powershell
Invoke-WebRequest `
  -Uri "https://huggingface.co/bartowski/Mistral-7B-Instruct-v0.3-GGUF/resolve/main/Mistral-7B-Instruct-v0.3-Q4_K_M.gguf" `
  -OutFile "$env:USERPROFILE\development\AI-models\llm\Mistral-7B-Instruct-v0.3-Q4_K_M.gguf"
```

## 5. Download the ComfyUI Models

### Required VAE

macOS and Linux:

```bash
curl -L --fail --continue-at - \
  --output ~/development/AI-models/comfyui/vae/sdxl_vae.safetensors \
  https://huggingface.co/stabilityai/sdxl-vae/resolve/main/diffusion_pytorch_model.safetensors
```

Windows PowerShell:

```powershell
Invoke-WebRequest `
  -Uri "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/diffusion_pytorch_model.safetensors" `
  -OutFile "$env:USERPROFILE\development\AI-models\comfyui\vae\sdxl_vae.safetensors"
```

### Required Image Checkpoint

Download the course-approved Pony SDXL checkpoint and place it exactly here:

macOS and Linux:

```text
~/development/AI-models/comfyui/checkpoints/ponyDiffusionV6XL_v6StartWithThisOne.safetensors
```

Windows:

```text
%USERPROFILE%\development\AI-models\comfyui\checkpoints\ponyDiffusionV6XL_v6StartWithThisOne.safetensors
```

Do not rename it. The starter ComfyUI workflow expects that filename.

## 6. Final Folder Check

### macOS and Linux

```bash
find ~/development/AI-models -maxdepth 4 -type f | sort
```

Minimum expected result if using the reference setup:

```text
~/development/AI-models/comfyui/checkpoints/ponyDiffusionV6XL_v6StartWithThisOne.safetensors
~/development/AI-models/comfyui/vae/sdxl_vae.safetensors
~/development/AI-models/llm/Mistral-7B-Instruct-v0.3-Q6_K.gguf
```

If you chose the smaller LLM, expect:

```text
~/development/AI-models/llm/Mistral-7B-Instruct-v0.3-Q4_K_M.gguf
```

### Windows PowerShell

```powershell
Get-ChildItem "$env:USERPROFILE\development\AI-models" -Recurse -File | Sort-Object FullName
```

Minimum expected result if using the reference setup:

```text
...\development\AI-models\comfyui\checkpoints\ponyDiffusionV6XL_v6StartWithThisOne.safetensors
...\development\AI-models\comfyui\vae\sdxl_vae.safetensors
...\development\AI-models\llm\Mistral-7B-Instruct-v0.3-Q6_K.gguf
```

## 7. What to Send Before Class

Send the instructor:

```text
Operating system:
CPU architecture:
RAM:
Downloaded LLM file:
Downloaded ComfyUI checkpoint:
Downloaded VAE:
```

Examples:

```text
Operating system: macOS
CPU architecture: arm64
RAM: 16 GB
Downloaded LLM file: Mistral-7B-Instruct-v0.3-Q6_K.gguf
Downloaded ComfyUI checkpoint: ponyDiffusionV6XL_v6StartWithThisOne.safetensors
Downloaded VAE: sdxl_vae.safetensors
```

## 8. What Not to Do

Do not put models inside:

```text
ComfyUI-stable/models
llama.cpp-stable/models
Downloads
Desktop
```

Keep all course models in:

```text
~/development/AI-models
```

This lets the local maintenance agent update ComfyUI and llama.cpp without moving or losing large model files.
