# AI/KI NodeCraft - Stable 8GB VRAM Pipelines

Welcome to the official repository of **AI/KI NodeCraft**! This space is dedicated to providing verified, rock-solid ComfyUI workflows optimized for budget 8GB VRAM consumer hardware and server cards.

📺 **YouTube Channel:** [AI/KI NodeCraft](https://youtube.com)

---

## 🛠️ THE 8GB GOLDEN RECOVERY RUNTIME

If you are tired of Out-of-Memory (OOM) errors, blurry textures, and broken execution loops from legacy nodes, this pipeline is for you. We leverage pure, modern audio-to-video diffusion directly in the latent space. 

### Verified Hardware Setup
*   **GPU:** NVIDIA Tesla P4 (8GB VRAM, Pascal Architecture) / Equivalent to GTX 1080  
    *Note: Headless server card without physical display outputs. The Linux desktop environment and monitor output are fully driven by the Intel CPU's iGPU, dedicating the Tesla card purely to AI inference.*
*   **OS:** Ubuntu 24.04.3 LTS (Noble Numbat)
*   **CPU:** Intel Core i7-6700T (Providing active Intel iGPU layer)
*   **System RAM:** 24 GB


### Lab Software & Runtime Alignment
Our lab operates completely headless regarding system-wide nvcc dependencies (`nvidia-cuda-toolkit` is NOT required). Instead, we rely entirely on the isolated execution layers inside our Python virtual environment to guarantee stable execution of modern latent diffusion networks.


| Component / Library | Version / Layer | Details |
| :--- | :--- | :--- |
| **NVIDIA Driver** | `580.159.03` | Data Center / Server Layer |
| **System CUDA Layer** | `13.0` | Reported by host `nvidia-smi` |
| **Python Runtime** | `3.12.x` | Isolated Virtual Environment (`venv`) |
| **Internal PyTorch** | `2.5.1+cu121` | Inherent Wheel optimized for Pascal VRAM management |
| **Transformers** | `5.9.0` | Mandatory for stable Qwen3-4B GGUF text parsing |
| **NumPy** | `2.3.5` | Strict Array Mode for post-processing masks |

### Optimization Command for Pascal Architecture
If you experience micro-stuttering or abrupt movement jumps during long multi-sampler passes (like Wan 2.1 or Float Advanced), we recommend aligning the internal wheels with the host layer using this command inside your active venv:

```bash
source venv/bin/activate
pip install torch torchvision torchaudio --index-url https://pytorch.org --upgrade
```

---

## 🚀 CRITICAL COMFYUI STARTUP FLAGS

To force strict VRAM conservation and allow models to fit into the 8GB limit on Pascal architectures, launch your ComfyUI instance with these exact flags. 

*Note: Since Pascal GPUs lack native FP16 hardware acceleration, `--force-fp16` acts as a mandatory memory-saving trade-off. It emulates lower precision to prevent CUDA OOMs at the cost of some inference speed.*

```bash
python main.py --lowvram --fast --force-fp16 --preview-method taesd --disable-smart-memory --disable-pinned-memory
```

## 📂 CURRENT WORKFLOWS IN THIS REPO

### 1. Pure Latent Audio-Driven Avatar
*   **Path:** `/workflows/26s_pure_latent_audio_driven_avatar.json`
*   **Features:** Z-Image Turbo GGUF-Q6 base pass, Float Advanced core audio-to-latent engine, 30 FPS VideoHelperSuite synchronization, BiRefNet local background removal.
*   **Output:** Exactly 780 frames of high-fidelity, synchronized video at 30 FPS driven by OmniVoice TTS.


---

## 🤝 COMMUNITY AND SUCCESS GUARANTEE
Every workflow uploaded here has been rigorously tested and executed on an actual 8GB Tesla P4 card drawing less than 75W under full load. Maximize your success, save your VRAM, and welcome to the lab!
