# Day 01 - Download the Local Models

This tutorial prepares the model files used during the day.

The objective is simple: every student should use the same folder layout, so the local agent can help them maintain both text generation and image generation without guessing where files are stored.

## Target Architecture

```text
~/development/
├── AI-models/
│   ├── llm/
│   │   └── Mistral-7B-Instruct-v0.3-Q6_K.gguf
│   └── comfyui/
│       ├── checkpoints/
│       │   └── ponyDiffusionV6XL_v6StartWithThisOne.safetensors
│       ├── vae/
│       │   └── sdxl_vae.safetensors
│       ├── loras/
│       ├── upscale_models/
│       ├── clip_vision/
│       ├── ipadapter/
│       ├── sams/
│       └── ultralytics/
├── llama.cpp-stable/
├── ComfyUI-stable/
└── llmWorkshopSummerSchool/
```

The engines and the model weights are separated:

| Folder | Role |
|---|---|
| `AI-models/llm/` | GGUF models used by `llama.cpp` |
| `AI-models/comfyui/` | Checkpoints, VAE, LoRAs, upscalers, and helper models used by ComfyUI |
| `llama.cpp-stable/` | Inference engine for local text generation |
| `ComfyUI-stable/` | Node-based image generation interface |
| `llmWorkshopSummerSchool/` | Course material and scripts |

## Required Models

| Use | File | Destination | Size |
|---|---|---|---|
| Local text agent | `Mistral-7B-Instruct-v0.3-Q6_K.gguf` | `AI-models/llm/` | about 5.5 GB |
| ComfyUI image generation | `ponyDiffusionV6XL_v6StartWithThisOne.safetensors` | `AI-models/comfyui/checkpoints/` | about 6.5 GB |
| SDXL image decoding | `sdxl_vae.safetensors` | `AI-models/comfyui/vae/` | about 319 MB |

Optional models already supported by the shared folder:

| Type | Destination | Why it exists |
|---|---|---|
| LoRA | `AI-models/comfyui/loras/` | Adds a style or concept to the base checkpoint |
| Upscaler | `AI-models/comfyui/upscale_models/` | Enlarges finished images |
| CLIP Vision | `AI-models/comfyui/clip_vision/` | Used by IP-Adapter and image-reference workflows |
| IP-Adapter | `AI-models/comfyui/ipadapter/` | Uses an image as a visual reference |
| SAM | `AI-models/comfyui/sams/` | Segmentation and masking workflows |
| Ultralytics | `AI-models/comfyui/ultralytics/` | Detection and segmentation helper models |

## macOS and Linux

Run these commands from a terminal.

```bash
mkdir -p ~/development/AI-models/llm
mkdir -p ~/development/AI-models/comfyui/checkpoints
mkdir -p ~/development/AI-models/comfyui/vae
```

Download the local LLM:

```bash
curl -L --fail --continue-at - \
  --output ~/development/AI-models/llm/Mistral-7B-Instruct-v0.3-Q6_K.gguf \
  https://huggingface.co/bartowski/Mistral-7B-Instruct-v0.3-GGUF/resolve/main/Mistral-7B-Instruct-v0.3-Q6_K.gguf
```

Download the SDXL VAE:

```bash
curl -L --fail --continue-at - \
  --output ~/development/AI-models/comfyui/vae/sdxl_vae.safetensors \
  https://huggingface.co/stabilityai/sdxl-vae/resolve/main/diffusion_pytorch_model.safetensors
```

Download the Pony SDXL checkpoint manually from the course source or approved model page, then place it here:

```text
~/development/AI-models/comfyui/checkpoints/ponyDiffusionV6XL_v6StartWithThisOne.safetensors
```

For this course, do not rename the file. The starter ComfyUI workflow expects that exact checkpoint name.

## Windows PowerShell

Run PowerShell from the user account that will run ComfyUI and llama.cpp.

```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\development\AI-models\llm"
New-Item -ItemType Directory -Force "$env:USERPROFILE\development\AI-models\comfyui\checkpoints"
New-Item -ItemType Directory -Force "$env:USERPROFILE\development\AI-models\comfyui\vae"
```

Download the local LLM:

```powershell
Invoke-WebRequest `
  -Uri "https://huggingface.co/bartowski/Mistral-7B-Instruct-v0.3-GGUF/resolve/main/Mistral-7B-Instruct-v0.3-Q6_K.gguf" `
  -OutFile "$env:USERPROFILE\development\AI-models\llm\Mistral-7B-Instruct-v0.3-Q6_K.gguf"
```

Download the SDXL VAE:

```powershell
Invoke-WebRequest `
  -Uri "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/diffusion_pytorch_model.safetensors" `
  -OutFile "$env:USERPROFILE\development\AI-models\comfyui\vae\sdxl_vae.safetensors"
```

Download the Pony SDXL checkpoint manually from the course source or approved model page, then place it here:

```text
%USERPROFILE%\development\AI-models\comfyui\checkpoints\ponyDiffusionV6XL_v6StartWithThisOne.safetensors
```

Do not rename the file.

## Verify the Files

macOS and Linux:

```bash
ls -lh ~/development/AI-models/llm
ls -lh ~/development/AI-models/comfyui/checkpoints
ls -lh ~/development/AI-models/comfyui/vae
```

Windows PowerShell:

```powershell
Get-ChildItem "$env:USERPROFILE\development\AI-models\llm"
Get-ChildItem "$env:USERPROFILE\development\AI-models\comfyui\checkpoints"
Get-ChildItem "$env:USERPROFILE\development\AI-models\comfyui\vae"
```

Expected minimum files:

```text
Mistral-7B-Instruct-v0.3-Q6_K.gguf
ponyDiffusionV6XL_v6StartWithThisOne.safetensors
sdxl_vae.safetensors
```

## Connect ComfyUI to the Shared Models

ComfyUI should not keep course models inside its own repo.

The file below tells ComfyUI where the shared image models live:

```text
~/development/ComfyUI-stable/extra_model_paths.yaml
```

For this setup, it should point to:

```text
~/development/AI-models/comfyui
```

That keeps updates clean:

```text
Update ComfyUI engine       -> ~/development/ComfyUI-stable
Update llama.cpp engine     -> ~/development/llama.cpp-stable
Add or replace model files  -> ~/development/AI-models
```

## Test llama.cpp

macOS and Linux:

```bash
cd ~/development/llama.cpp-stable

build/bin/llama-cli \
  -m ~/development/AI-models/llm/Mistral-7B-Instruct-v0.3-Q6_K.gguf \
  -p "Say hello in one short sentence." \
  -n 60 \
  --no-display-prompt \
  --single-turn
```

On Macs where Metal fails, use the stable CPU fallback:

```bash
build/bin/llama-cli \
  -m ~/development/AI-models/llm/Mistral-7B-Instruct-v0.3-Q6_K.gguf \
  -p "Say hello in one short sentence." \
  -n 60 \
  --no-display-prompt \
  --single-turn \
  --device none \
  -ngl 0 \
  --no-op-offload
```

Windows PowerShell:

```powershell
cd "$env:USERPROFILE\development\llama.cpp-stable"

.\build\bin\llama-cli.exe `
  -m "$env:USERPROFILE\development\AI-models\llm\Mistral-7B-Instruct-v0.3-Q6_K.gguf" `
  -p "Say hello in one short sentence." `
  -n 60 `
  --no-display-prompt `
  --single-turn
```

## Test ComfyUI

Start ComfyUI from the stable repo:

```bash
cd ~/development/ComfyUI-stable
. .venv/bin/activate
python main.py
```

Then open the local browser URL shown by ComfyUI.

In the checkpoint loader node, the checkpoint list should include:

```text
ponyDiffusionV6XL_v6StartWithThisOne.safetensors
```

In the VAE loader node, the VAE list should include:

```text
sdxl_vae.safetensors
```

## What the Student Should Remember

Models are not the app.

The app is replaceable:

```text
ComfyUI-stable
llama.cpp-stable
```

The model files are the large local assets:

```text
AI-models
```

When an agent helps maintain the environment, it should usually update the app repos, rebuild engines, or add models to `AI-models`. It should not scatter model files across several application folders.
