# Getting Started with the Local AI Agent

This note explains the two workshop scripts that now matter:

| Script | Purpose |
|---|---|
| `run_local_mistral.sh` | Starts the model in the terminal or Web UI |
| `local_agent.py` | Runs the project-aware coding assistant |

The shared model layout is documented in [00-BeforeCoursePrep-Models.md](./00-BeforeCoursePrep-Models.md).
The `llama.cpp` engine install is documented in [InstallLlamaCpp.md](./InstallLlamaCpp.md).

## Verify the Environment

```bash
python3 --version
```

You need Python 3.10 or newer.

Check that the model and engine are in the expected places:

```bash
ls ~/development/AI-models/llm/
ls ~/development/llama.cpp-stable/build/bin/
```

## Run The Model

Terminal chat:

```bash
cd ~/development/llmWorkshopSummerSchool
./run_local_mistral.sh chat
```

One prompt and exit:

```bash
./run_local_mistral.sh once "Write a short story about a mysterious cabin in the woods."
```

Web UI:

```bash
./run_local_mistral.sh web
```

## Run The Agent

`local_agent.py` is the workshop coding assistant. It:

- asks which project to inspect
- builds a project summary from the file tree
- stores prompts and answers in SQLite
- calls the shared Mistral model from `~/development/AI-models/llm/`

Run it from the workshop repo root:

```bash
cd ~/development/llmWorkshopSummerSchool
python3 local_agent.py
```

## What Changed From Older Notes

The old setup files in this repo used a model folder inside `llama.cpp`. That is no longer the baseline.

The current baseline is:

```text
~/development/AI-models/llm/
~/development/llama.cpp-stable/
~/development/llmWorkshopSummerSchool/
```

That separation keeps model files stable while the engine and workshop notes evolve.
