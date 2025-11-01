Title: feat(comfyui): ComfyUI RTX50 patch (PyTorch >=2.8 + CUDA 12.6)

Summary:
- Adds GPU (CUDA 12.6 + PyTorch ≥2.8) and CPU Dockerfiles for ComfyUI, example compose, smoke test, model download helpers, and documentation.
- Preserves UNFINISHED TODOS in docs/COMFYUI_TODO.md exactly as provided (not auto-cleared).
- Adds optional manual GitHub Actions workflow for building/pushing image to Docker Hub.

Why:
- Fixes "no kernel image" compatibility for RTX 50-series GPUs by using compatible PyTorch/CUDA stack.

How to test (smoke steps):
1. Build & run (local GPU)
   docker build -f docker/comfyui/Dockerfile.gpu -t comfyui-rtx50:local .
   docker compose -f docker-compose.example.yml up -d --build
2. Verify CUDA inside container:
   docker exec -it comfyui-rtx50 python /home/comfy/ComfyUI/scripts/test_torch_gpu.py
3. Confirm logs show no "no kernel image" errors.

Acceptance criteria:
- test_torch_gpu.py shows `cuda available: True` and lists your RTX 50xx device name (or CPU fallback success).
- ComfyUI logs contain no "no kernel image" or sm_90 errors.
- docs/COMFYUI_TODO.md remains unchanged and present in PR.
- No model weights included in the repo.

Notes:
- This repo provides patch artifacts only. Users must download model files via the included scripts.
- If you want me to push images to Docker Hub, add DOCKERHUB_USERNAME and DOCKERHUB_TOKEN as repo secrets.

Please review and merge when smoke tests pass.
