# AI/KI NodeCraft - Stable 8GB VRAM Pipelines

Welcome to the official repository of AI/KI NodeCraft! This space is dedicated to providing verified, rock-solid ComfyUI workflows optimized for budget 8GB VRAM consumer hardware and server cards.

📺 YouTube Channel: https://youtube.com

---

## 🛠️ THE 8GB GOLDEN RECOVERY RUNTIME

If you are tired of Out-of-Memory (OOM) errors, blurry textures, and broken execution loops from legacy nodes like Wav2Lip, this pipeline is for you. We leverage pure, modern audio-to-video diffusion directly in the latent space.

### Verified Hardware Setup
- GPU: NVIDIA Tesla P4 (8GB VRAM, Pascal Architecture) / Equivalent to GTX 1080
- OS: Ubuntu 24.04 LTS
- CPU: Intel Core i7-6700T
- System RAM: 24 GB
- Hostname: Tesla-AI

### Lab Software & Runtime Alignment
Our lab operates completely headless regarding system-wide nvcc dependencies (nvidia-cuda-toolkit is NOT required). Instead, we rely entirely on the isolated execution layers inside our Python virtual environment.

Current production environment:
- NVIDIA Driver: Version 580.159.03 (System CUDA Layer: 13.0)
- Python Runtime: Version 3.12.x (With isolated venv)
- Internal PyTorch Layer: Version 2.5.1+cu121 (CUDA 12.1 Inherent Wheel)

### Optimization Command for Pascal Architecture
If you experience micro-stuttering or abrupt movement jumps during long multi-sampler passes (like Wan 2.1 or Float Advanced), we recommend aligning the internal wheels with the host layer using this command inside your venv:
pip install torch torchvision torchaudio --index-url https://pytorch.org --upgrade

---

## 🚀 CRITICAL COMFYUI STARTUP FLAGS

To force dynamic memory shifting and FP16/FP8 matrix calculations on Pascal architectures, launch your ComfyUI instance with these exact flags:

python main.py --lowvram --fast --force-fp16 --preview-method taesd --disable-smart-memory --disable-pinned-memory

---

## 📂 CURRENT WORKFLOWS IN THIS REPO

1. /workflows/22s_pure_latent_audio_driven_avatar.json
   - Features: Z-Image Turbo GGUF-Q6 base pass, Float Advanced core audio-to-latent engine, 30 FPS VideoHelperSuite synchronization, BiRefNet local background removal.
   - Output: Exactly 660 frames of high-fidelity, synchronized video at 30 FPS driven by OmniVoice TTS. (NO Wav2Lip quality-loss).

---

## 🤝 COMMUNITY AND SUCCESS GUARANTEE
Every workflow uploaded here has been rigorously tested and executed on an actual 8GB Tesla P4 card drawing less than 75W under full load. Maximize your success, save your VRAM, and welcome to the lab!
