# Build Status — comfyui-rtx50-patch

Date: 2025-11-01
Status: Ready for build & smoke test

## Delta

- Added GPU (CUDA 12.6 + PyTorch ≥2.8) and CPU Dockerfiles
- Added example compose for ComfyUI + ai-router integration
- Added CUDA smoke test script
- Added model download helpers (no weights committed)
- Added docs (compatibility, troubleshooting, TODOs)
- Added optional manual GitHub Actions workflow (build & push)
- CPU optimization note: If a CPU-only LLM service is running elsewhere (e.g., llama.cpp), stop or throttle it to avoid host contention during GPU tests

## How to build & test

1) Build GPU image (requires NVIDIA drivers + Docker setup)

```powershell
# PowerShell
docker build -f docker/comfyui/Dockerfile.gpu -t comfyui-rtx50:local .
```

2) Start stack

```powershell
# PowerShell
docker compose -f docker-compose.example.yml up -d --build
```

3) Verify CUDA inside container

```powershell
# PowerShell
docker exec -it comfyui-rtx50 python /home/comfy/ComfyUI/scripts/test_torch_gpu.py
```

Expected: `cuda available: True` and RTX 50xx device name listed.

4) Logs

- Create `ai-reports/comfyui/BUILD-logs-<timestamp>.md` with outputs from build/test
