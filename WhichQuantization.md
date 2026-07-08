# 🧠 Choosing the Right Mistral Model Version

Use this guide to select the best Mistral model variant (`.gguf` format) for your system based on available RAM and hardware.

---

## 📊 Mistral Model Quantization Guide

| Model Variant                        | Approx. Size | RAM Required | Quality        | Speed     | Recommended For                           |
| ------------------------------------ | ------------ | ------------ | -------------- | --------- | ----------------------------------------- |
| `Mistral-7B-Instruct-v0.3-Q4_K_M.gguf` | ~3.8 GB      | ≥ 8 GB       | Good           | Fast      | Balanced quality/size, most systems       |
| `Mistral-7B-Instruct-v0.3-Q5_K_M.gguf` | ~4.5 GB      | ≥ 10 GB      | Very Good      | Good      | Best quality/size balance                 |
| `Mistral-7B-Instruct-v0.3-Q6_K.gguf` | ~5.5 GB      | ≥ 12 GB      | High           | Moderate  | M1/M2/M3 Macs, modern CPUs                |
| `Mistral-7B-Instruct-v0.3-Q8_K_M.gguf` | ~7.5 GB      | ≥ 14–16 GB   | Very High      | Slower    | Workstations, best quality                |
| `Mistral-7B-Instruct-v0.3-Q2_K.gguf` | ~2.5 GB      | ≥ 4 GB       | Low            | Very Fast | Minimal setups (Raspberry Pi, legacy PCs) |

---

## 💡 Tips

- ✅ **Mac M-series** (like M3): Best performance with `Q5_K_M` or `Q6_K` using Metal backend.
- 🧠 **Smaller quantizations** (Q4_K_M, Q5_K_M) run on most machines with good quality.
- 🚀 **For coding tasks**: Use at least `Q5_K_M` or `Q6_K` to preserve reasoning ability.
- 🔒 **Local usage only**: All variants are compatible with `llama.cpp` and stay offline.

---

## 📥 Where to Download

Get the models here:  
👉 [bartowski/Mistral-7B-Instruct-v0.3-GGUF](https://huggingface.co/bartowski/Mistral-7B-Instruct-v0.3-GGUF)

Make sure to pick the `.gguf` format matching your quantization level.
