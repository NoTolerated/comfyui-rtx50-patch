# ComfyUI GPU Compatibility Issue (RTX 50xx)

Symptoms:
- "no kernel image is available for execution on the device" on RTX 50xx (sm_120)
- Caused by PyTorch builds targeting older compute capabilities (sm_90)

Fix:
- Use PyTorch >= 2.8 built for CUDA 12.6 (cu126) to support sm_120 devices.

Testing:
- Run `python services/comfyui/scripts/test_torch_gpu.py` inside container
- Confirm "cuda available: True" and the RTX 50xx device name listed

Notes:
- Do NOT commit model weights. Use provided download scripts to fetch SDXL or other models.
- Add your GPU driver and tested torch wheel version to the compatibility table in COMPATIBILITY.md.
