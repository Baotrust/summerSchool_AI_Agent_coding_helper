# 🧠 Choosing the Right Mistral Model Version

Use this guide to select the best Mistral model variant (`.gguf` format) for your system based on available RAM and hardware.

---

## 📊 Mistral Model Quantization Guide

| Model Variant                        | Approx. Size | RAM Required | Quality        | Speed     | Recommended For                           |
| ------------------------------------ | ------------ | ------------ | -------------- | --------- | ----------------------------------------- |
| `mistral-7b-instruct-v0.1.Q2_K.gguf` | ~2.5 GB      | ≥ 4 GB       | Low            | Very Fast | Minimal setups (Raspberry Pi, legacy PCs) |
| `mistral-7b-instruct-v0.1.Q4_K.gguf` | ~4.2 GB      | ≥ 6 GB       | Medium         | Fast      | Older laptops, low-memory devices         |
| `mistral-7b-instruct-v0.1.Q5_K.gguf` | ~4.8 GB      | ≥ 8 GB       | Good           | Good      | Balanced performance + quality            |
| `mistral-7b-instruct-v0.1.Q6_K.gguf` | ~5.5 GB      | ≥ 10 GB      | High           | Moderate  | M1/M2/M3 Macs, modern CPUs                |
| `mistral-7b-instruct-v0.1.Q8_0.gguf` | ~8.1 GB      | ≥ 14–16 GB   | Very High      | Slower    | Workstations, server setups               |
| `mistral-7b-instruct-v0.1.f16.gguf`  | ~13.4 GB     | ≥ 24–32 GB   | Maximum (FP16) | Slowest   | Research, full-precision needs            |

---

## 💡 Tips

- ✅ **Mac M-series** (like M3): Best performance with `Q6_K` or `Q8_0` using Metal backend.
- 🧠 **Smaller quantizations** (Q2, Q4) run on low-end machines but may degrade output quality.
- 🚀 **For coding tasks**: Use at least `Q5_K` or `Q6_K` to preserve reasoning ability.
- 🔒 **Local usage only**: All variants are compatible with `llama.cpp` and stay offline.

---

## 📥 Where to Download

Get the models here:  
👉 [TheBloke's Hugging Face page](https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF)

Make sure to pick the `.gguf` format matching your quantization level.
