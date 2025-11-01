# Documentation Map (comfyui-rtx50-patch)

This repo contains the ComfyUI RTX50 patch artifacts only.

- `docker/comfyui/Dockerfile.gpu` — CUDA 12.6 + PyTorch ≥2.8 GPU image
- `docker/comfyui/Dockerfile.cpu` — CPU fallback image
- `docker-compose.example.yml` — Example stack (ComfyUI + ai-router)
- `services/comfyui/scripts/test_torch_gpu.py` — CUDA smoke test
- `scripts/download-models.ps1` — PowerShell model downloader
- `scripts/download-models.sh` — Bash model downloader
- `docs/COMFYUI_GPU_COMPATIBILITY_ISSUE.md` — RTX 50xx fix guide
- `docs/COMPATIBILITY.md` — GPU compatibility matrix
- `docs/COMFYUI_TODO.md` — UNFINISHED TODOS (must remain unchanged)
- `BUILD_STATUS.md` — Build/test status and deltas
- `.github/workflows/build-and-push.yml` — Manual Docker build & push
