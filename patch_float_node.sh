#!/bin/bash

# ==============================================================================
# 🚀 ACCYXX FLOAT PIPELINE RECOVERY PATCH
# Target: Fixes Transformers 5.9.0+ weights tying crash in FLOAT-Optimized
# ==============================================================================

COMFY_DIR="$(pwd)"
FLOAT_DIR="$COMFY_DIR/custom_nodes/ComfyUI-FLOAT_Optimized"

echo "--------------------------------------------------------"
echo "🛠️ Starting FLOAT-Optimized Patch..."
echo "--------------------------------------------------------"

if [ -d "$FLOAT_DIR" ]; then
    echo "📦 Found FLOAT-Optimized. Applying compatibility hotfix..."
    cd "$FLOAT_DIR"
    
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

cd "$COMFY_DIR"
echo "--------------------------------------------------------"
echo "🎉 Done! Please restart ComfyUI now."
echo "--------------------------------------------------------"
