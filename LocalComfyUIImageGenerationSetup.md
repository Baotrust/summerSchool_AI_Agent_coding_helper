# 🎨 Local Image Generation With ComfyUI

<p>
  <span style="color:#0ea5e9"><strong>Workshop mini-module</strong></span> ·
  <span style="color:#22c55e"><strong>Local-first</strong></span> ·
  <span style="color:#f97316"><strong>Agent-assisted setup</strong></span>
</p>

---

## 🟦 Slide 1 — What Are We Trying To Build?

We want each student to run a **local image-generation workspace** where they can:

- Generate images from prompts
- Reuse curated workflow templates
- Understand what model, workflow, and prompt mean
- Keep control of their files, outputs, and learning process
- Ask a local AI agent for setup and maintenance help

> Objective: give students a practical creative AI environment without starting from vendor-locked black boxes.

---

## 🟩 Slide 2 — Why Not Only Use A Web App?

Cloud image tools are useful, but they hide many important concepts:

| Web App | Local ComfyUI |
| --- | --- |
| Easy first click | Teaches how generation works |
| Vendor account required | Can run with local models |
| Limited control | Full workflow control |
| Changing pricing/rules | Environment can be preserved |
| Hard to inspect | Every node is visible |

<span style="color:#16a34a"><strong>Learning gain:</strong></span> students see the pipeline, not just the final button.

---

## 🟨 Slide 3 — The Big Idea

ComfyUI is a **visual workflow engine**.

Instead of one hidden "generate" button, students see the steps:

```text
Model
  ↓
Prompt
  ↓
Sampler
  ↓
VAE Decode
  ↓
Saved Image
```

This makes image generation teachable:

- What model is used?
- Where is the prompt?
- Why does resolution matter?
- What does the sampler do?
- Where is the output saved?

---

## 🟧 Slide 4 — What We Prepared

We prepared a clean stable ComfyUI environment:

```text
~/development/ComfyUI-stable
```

With:

- ComfyUI `v0.27.0`
- Python virtual environment
- Apple Silicon / MPS support
- ComfyUI Manager installed
- A stable model folder layout
- A minimal built-in workflow for first image generation

<span style="color:#ea580c"><strong>Important:</strong></span> the first workflow avoids custom nodes so the first success is simple.

---

## 🟪 Slide 5 — Three Things Students Must Understand

### 1. Model

The learned image generator weights.

Example:

```text
ponyDiffusionV6XL_v6StartWithThisOne.safetensors
```

### 2. Workflow

The ComfyUI graph describing the generation pipeline.

Example:

```text
simple-pony-text-to-image.json
```

### 3. Prompt

The human instruction that describes the image.

Example:

```text
score_9, score_8_up, a cinematic portrait of a student learning digital art
```

---

## 🟥 Slide 6 — Why Start Simple?

Advanced community workflows often include:

- Face detailers
- Upscalers
- LoRAs
- IP-Adapter
- ControlNet
- Custom nodes
- Extra detector models

Those are powerful, but each one can break the first lesson.

So the first student workflow should use only core nodes:

```text
CheckpointLoaderSimple
CLIPTextEncode
KSampler
VAEDecode
SaveImage
```

<span style="color:#dc2626"><strong>Rule:</strong></span> first prove the engine works, then add creative power.

---

## 🟦 Slide 7 — Local Folder Logic

The stable ComfyUI folder owns the active environment:

```text
ComfyUI-stable/
├── user/default/workflows/
└── output/
```

Key idea:

- Models go in `~/development/AI-models/comfyui/`
- Workflows go in `user/default/workflows/`
- Generated images go in `output/`

---

## 🟩 Slide 8 — What Goes Where?

| File type | Folder | Purpose |
| --- | --- | --- |
| Checkpoint `.safetensors` | `~/development/AI-models/comfyui/checkpoints/` | Main image model |
| VAE `.safetensors` | `~/development/AI-models/comfyui/vae/` | Decodes latent image to pixels |
| LoRA `.safetensors` | `~/development/AI-models/comfyui/loras/` | Adds style or concept |
| Upscaler `.pth` | `~/development/AI-models/comfyui/upscale_models/` | Enlarges image |
| Workflow `.json` | `user/default/workflows/` | Reusable generation graph |

This structure matters because ComfyUI scans these folders automatically through `~/development/ComfyUI-stable/extra_model_paths.yaml`.

---

## 🟨 Slide 9 — First Generation Workflow

For the first exercise, students open:

```text
ComfyUI-stable/user/default/workflows/simple-pony-text-to-image.json
```

The workflow is intentionally small:

```text
Pony checkpoint
  ↓
Positive + negative prompt
  ↓
KSampler
  ↓
VAE decode
  ↓
Save image
```

No custom node dependency. No cloud dependency. No account required.

---

## 🟧 Slide 10 — What Students Change First

Students only change the **positive prompt** at first.

Example:

```text
score_9, score_8_up, score_7_up,
a friendly robot teaching programming in a summer school classroom,
colorful lighting, clean composition, detailed background
```

They leave these alone at first:

- Model
- Sampler
- Steps
- CFG
- Resolution
- VAE

<span style="color:#f97316"><strong>Teaching intent:</strong></span> isolate one variable at a time.

---

## 🟪 Slide 11 — Why Use A Local Agent?

The local agent is not here to replace the teacher.

It helps students with repetitive environment work:

- "Where should this model file go?"
- "Why is my workflow missing a node?"
- "Which folder contains generated images?"
- "What does this ComfyUI error mean?"
- "Can this machine run this model?"

<span style="color:#9333ea"><strong>Gain:</strong></span> the teacher focuses on concepts while the agent helps with setup friction.

---

## 🟥 Slide 12 — What The Agent Should Protect

The agent should keep students from unsafe maintenance habits:

- Do not randomly delete model folders
- Do not mix old and new ComfyUI installs without knowing why
- Do not install every custom node from the internet
- Do not upgrade everything during a class exercise
- Do not use cloud partner nodes without understanding credits and accounts

The agent should ask before:

- Moving large model files
- Removing old installs
- Installing custom nodes
- Downloading new models
- Changing workflow files

---

## 🟦 Slide 13 — Local vs Cloud Image Generation

Students should understand the difference:

| Mode | What runs where? | Best for |
| --- | --- | --- |
| Local model | Student machine | Privacy, control, learning |
| Partner/API node | Vendor cloud | Powerful closed models, paid experiments |
| Cloud GPU self-host | Remote GPU, open workflow | Students without strong hardware |

For the base workshop, we start with:

```text
Local ComfyUI + local SDXL/Pony model
```

Cloud options are optional extensions.

---

## 🟩 Slide 14 — Course Outcome

At the end of this module, students should be able to explain:

- A model is not the same as a workflow
- A workflow is not the same as a prompt
- Local generation gives more control and inspectability
- Templates make image generation accessible without hiding the pipeline
- An agent can help maintain the environment without owning the creative goal

They should also be able to generate a first image locally.

---

## 🟨 Slide 15 — Handoff Point

At this point, the teacher stops the presentation.

The student opens their terminal and the local agent takes over.

The agent should now help each student verify:

```text
1. ComfyUI-stable exists
2. Python environment works
3. Required checkpoint is present
4. Simple workflow is available
5. ComfyUI starts locally
6. First image can be generated
```

---

## 🟧 Slide 16 — Agent Handoff Prompt

Students can now ask the local agent:

```text
Help me check my local ComfyUI image generation setup.

I need to verify:
- where my ComfyUI-stable folder is
- whether the Pony/SDXL checkpoint is installed
- whether the simple workflow is available
- how to start ComfyUI
- how to open the workflow and edit the prompt

Do not move, delete, or install anything without asking me first.
```

<span style="color:#ea580c"><strong>Stop here.</strong></span> The next part is interactive and machine-specific.
