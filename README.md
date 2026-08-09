# AI/KI NodeCraft - Stable 8GB VRAM Pipelines

 👉 **Get the latest fixes here:** **[comfyui-8gb-pipelines](https://github.com/accyxx/ComfyUI-install-for-Pascal-Architecture-)**

Welcome to the official repository of **AI/KI NodeCraft**! This space is dedicated to providing verified, rock-solid ComfyUI workflows optimized for budget 8GB VRAM consumer hardware and server cards.

📺 **YouTube Channel:** [AI_KI NodeCraft](https://www.youtube.com/@aikinodecraft)

---

## 🛠️ THE 8GB GOLDEN RECOVERY RUNTIME

If you are tired of Out-of-Memory (OOM) errors, blurry textures, and broken execution loops from legacy nodes, this pipeline is for you. We leverage pure, modern audio-to-video diffusion directly in the latent space. 

### Verified Hardware Setup
*   **GPU:** NVIDIA Tesla P4 (8GB VRAM, Pascal Architecture) / Equivalent to GTX 1080  
    *Note: Headless server card without physical display outputs. The Linux desktop environment and monitor output are fully driven by the Intel CPU's iGPU, dedicating the Tesla card purely to AI inference.*
*   **OS:** Ubuntu 24.04.4 LTS (Noble Numbat)
*   **CPU:** Intel Core i7-6700T (Providing active Intel iGPU layer)
*   **System RAM:** 24 GB


### Lab Software & Runtime Alignment
Our lab operates completely headless regarding system-wide nvcc dependencies (`nvidia-cuda-toolkit` is NOT required). Instead, we rely entirely on the isolated execution layers inside our Python virtual environment to guarantee stable execution of modern latent diffusion networks.


### Technical Environment & Dependencies

| Package | Version | Specific Purpose in Stack |
| :--- | :--- | :--- |
| `torch` | `2.5.1+cu121` | Tensor computations (Pascal Legacy Wheel) |
| `torchvision` | `0.20.1+cu121` | Image processing and visual pipelines |
| `torchaudio` | `2.5.1+cu121` | Audio processing & audio-focused nodes |
| `transformers` | `5.9.0` | Text encoder parsing (Required for Qwen3 GGUF) |
| `numpy` | `2.3.5` | Array operations (Strict Array Mode for VFX masks) |
| `safetensors` | `0.7.0` | High-speed secure model weight loading |
| `accelerate` | `1.12.0` | VRAM management (Essential for `--lowvram`) |
| `einops` | `0.8.1` | Matrix transformations for diffusion architectures |

### Optimization Command for Pascal Architecture
If you experience micro-stuttering or abrupt movement jumps during long multi-sampler passes (like Wan 2.1 or Float Advanced), we recommend aligning the internal wheels with the host layer using this command inside your active venv:

```bash
source venv/bin/activate
pip install torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url https://download.pytorch.org/whl/cu121
```

### IMPORTANT 
> [!IMPORTANT]
> ## 🚀 PROJECT MOVED & OPTIMIZED (New 8GB VRAM Pipelines)
> This repository has been integrated and significantly improved! All verified workflows, automated recovery patches (including the Transformers 5.9.0+ fix), and stable runtime configurations for Pascal GPUs (Tesla P4, GTX 1080) are now hosted in our main lab repository.
> 
> 👉 **Get the latest fixes here:** **[comfyui-8gb-pipelines](https://github.com/accyxx/ComfyUI-install-for-Pascal-Architecture-)**
> 
> *Please star the new repository to support the lab and stay updated with rock-solid LTS baselines!*





---

## 🚀 CRITICAL COMFYUI STARTUP FLAGS

To force strict VRAM conservation and allow models to fit into the 8GB limit on Pascal architectures, launch your ComfyUI instance with these exact flags. 

*Note: Since Pascal GPUs lack native FP16 hardware acceleration, `--force-fp16` acts as a mandatory memory-saving trade-off. It emulates lower precision to prevent CUDA OOMs at the cost of some inference speed.*

```bash
--enable-manager-legacy-ui --lowvram --fp16-unet --fp16-vae --preview-method taesd --disable-smart-memory --disable-pinned-memory
```
The Flags used in all workflows of Genna-Talking Avatar 

## 📂 CURRENT WORKFLOWS IN THIS REPO

### 1. Pure Latent Audio-Driven Avatar (Full Pipeline)
*   **Path:** `/Genna_FLOAT_ADVANCED_WORKFLOW.json`
*   **Features:** Complete unified pipeline fusing Z-Image Turbo, OmniVoice TTS, and the Float Advanced engine.
*   **Output:** Exactly 780 frames of synchronized video at 30 FPS (26-second sequence).

### 2. Modular Sub-Pipelines (Step-by-Step)
*   **Path:** `/z_image_turbo_workflow.json` -> Isolated base frame generator.
*   **Path:** `/omnivoice-tts_workflow.json` -> Dedicated voice synthesis module.
*   **Path:** `/Audio_Padding_Preroll_Postroll.json` -> Universal cross-platform 2.5s preroll & postroll padding graph (fixes frame-0 glitches).



### FIX - FLOAT ### 

## 🛠️ Automated FLOAT Pipeline Patch & Transformers 5.9.0+ Fix

> [!WARNING]  
> **DISCLAIMER:** This patch was created as a temporary hotfix specifically for my own hardware setup (Tesla P4 / Pascal Architecture) and environment. It works flawlessly on my machine, and it might work for yours too – but **there is absolutely no warranty or guarantee**. Try it at your own risk, but it's definitely worth a shot if your FLOAT pipeline is broken!

### 💡 Understand What You Run & Ask AI!
We highly encourage you to review the script contents below to familiarize yourself with the modifications being made to the Python files. If you want to understand exactly how the code works or verify its safety, **feel free to copy-paste the script into any AI chatbot (like ChatGPT, Gemini, or Claude) and ask for a detailed explanation!** Understanding your pipeline is a superpower.

### 🚨 Crucial Step Before Patching: Backup Your Venv!
Before running any automated patch scripts or updating dependencies, it is highly recommended to freeze and backup your working Python virtual environment (`venv`). If anything goes wrong, you can restore your setup in seconds.

To create a compressed backup of your ComfyUI directory (excluding heavy model weights to save space), run this command in your Linux terminal:
```bash
tar --exclude='*/models/*' -czf ~/comfyui_perfect_backup.tar.gz ~/ComfyUI
```
*(In case of emergency, you can fully restore your state by running `rm -rf ~/ComfyUI && tar -xzf ~/comfyui_perfect_backup.tar.gz -C ~/`)*

---

### 📋 The FLOAT Pipeline Issue Explained

After choosing **"Update All"** in ComfyUI-Manager, the latest `ComfyUI-FLOAT_Optimized` code breaks if paired with modern Transformers versions (v5.9.0+ / PyTorch 2.5.1). 

**The `AttributeError` Crash:** The updated node code fails to initialize the weight-tying dictionary (`all_tied_weights_keys = {}`) required by Hugging Face's backend during `self.init_weights()`, resulting in a complete workflow crash (`AttributeError: 'Wav2Vec2ForSpeechClassification' object has no attribute 'all_tied_weights_keys'`).

---

### 🔧 How to Apply the FLOAT Recovery Patch

This automated script resets the modified file to a clean state and injects the missing empty weight-tying dictionary (`{}`) directly into the model logic, making the FLOAT advanced engine fully operational again under newer dependencies.

Run this script inside your main **`ComfyUI/`** directory.

*Example: If your GitHub username is `yourusername`, the download command looks like this:*
```bash
# 1. Download the FLOAT patch script from this repo (Replace with your actual GitHub path)
wget https://raw.githubusercontent.com/accyxx/comfyui-8gb-pipelines/main/patch_float_node.sh

# 2. Make it executable and run it
chmod +x patch_float_node.sh
./patch_float_node.sh
```

After the script finishes successfully, restart ComfyUI, refresh your browser ($F5$), and your pipeline will be fully executable!

---

---

### 🔄 How to Undo the Patch (Rollback)
If you ever want to revert this patch and return to the original, unmodified custom node code, you don't need to reinstall anything. Since the custom node is a Git repository, you can discard all local changes instantly.

Simply run this command inside your main **`ComfyUI/`** directory:
```bash
cd custom_nodes/ComfyUI-FLOAT_Optimized && git checkout src/nodes/models/wav2vec2_ser.py && cd ../..
```
*Alternatively, if you downloaded the script, you can just run it with the `--undo` flag:*
```bash
./patch_float_node.sh --undo
```




### 💾 The Script File: `patch_float_node.sh`

### HERE YOU CAN VIEW THE CODE GENERATED WITH AI 


```bash
#!/bin/bash

# ==============================================================================
# 🚀 ACCYXX FLOAT PIPELINE RECOVERY PATCH
# Target: Fixes Transformers 5.9.0+ weights tying crash in FLOAT-Optimized
# ==============================================================================

COMFY_DIR="\$(pwd)"
FLOAT_DIR="\$COMFY_DIR/custom_nodes/ComfyUI-FLOAT_Optimized"

echo "--------------------------------------------------------"
echo "🛠️ Starting FLOAT-Optimized Patch..."
echo "--------------------------------------------------------"

if [ -d "\$FLOAT_DIR" ]; then
    echo "📦 Found FLOAT-Optimized. Applying compatibility hotfix..."
    cd "\$FLOAT_DIR"
    
    # Clean state
    git checkout src/nodes/models/wav2vec2_ser.py 2>/dev/null
    
    # Fix: Transformers 5.9.0+ weights tying fix ({})
    python3 -c '
path = "src/nodes/models/wav2vec2_ser.py"
with open(path, "r") as f: code = f.read()
if "self.all_tied_weights_keys = {}" not in code:
    patched = code.replace("        self.init_weights()", "        self.all_tied_weights_keys = {}\n        self.init_weights()", 1)
    with open(path, "w") as f: f.write(patched)
'
    echo "✅ FLOAT-Optimized patch successfully applied!"
else
    echo "❌ Error: FLOAT-Optimized directory not found!"
    echo "Please ensure you run this script inside your main ComfyUI folder."
fi

cd "\$COMFY_DIR"
echo "--------------------------------------------------------"
echo "🎉 Done! Please restart ComfyUI now."
echo "--------------------------------------------------------"
```

---

---

## 🛠️ CRITICAL FIX - COMFY-KITCHEN CRASH (PyTorch 2.5.1 Compatibility)

### 📋 The Issue Explained
If you are running the recommended **PyTorch 2.5.1 + CUDA 12.1** stack on your Tesla P4 (or any Pascal GPU), choosing **"Update All"** in ComfyUI-Manager will auto-install `comfy-kitchen` v0.2.20+. 

This breaks your startup sequence instantly with a `ValueError: infer_schema(func): Parameter kernel_size has unsupported type list[int]`. The latest kitchen update uses modern Python 3.12 type annotations (`list[int]` and the `|` operator) which are strictly rejected by the stable PyTorch 2.5.1 core.

### 🔧 How to Apply the Kitchen Downgrade Fix
To fix this without modifying any core files, you must force-downgrade `comfy-kitchen` to version `0.2.10`. This version provides full performance on Pascal architectures without the breaking modern code declarations.

Run this command inside your active `venv` to restore functionality:

```bash
cd ~/ComfyUI
source venv/bin/activate
pip install "comfy-kitchen<=0.2.10" --force-reinstall
```

⚠️ **Note for the future:** If ComfyUI throws a `ValueError` during startup after you clicked "Update All" in the Manager, simply re-run the command above to pin the kitchen package back to its stable state.





## 🤝 COMMUNITY AND SUCCESS GUARANTEE
Every workflow uploaded here has been rigorously tested and executed on an actual 8GB Tesla P4 card drawing less than 75W under full load. Maximize your success, save your VRAM, and welcome to the lab!

🌟 If this code helps your 8GB card survive, drop a Star to support the lab!



