# comfyui-rtx50-patch

Public patch artifacts to run ComfyUI on RTX 50xx GPUs using CUDA 12.6 + PyTorch ≥2.8.

📖 **[Documentation Map](docs/DOCUMENTATION_MAP.md)** — Complete guide to all documentation and resources.

- No model weights are included. Use the download scripts to fetch models.
- Contains GPU/CPU Dockerfiles, example compose, smoke test, and docs.

## Quick start

Requirements:
- NVIDIA GPU + drivers
- Docker + NVIDIA Container Toolkit

Build GPU image:

```powershell
# PowerShell
docker build -f docker/comfyui/Dockerfile.gpu -t comfyui-rtx50:local .
```

Start stack:

```powershell
# PowerShell
docker compose -f docker-compose.example.yml up -d --build
```

Smoke test CUDA inside container:

```powershell
# PowerShell
docker exec -it comfyui-rtx50 python /home/comfy/ComfyUI/scripts/test_torch_gpu.py
```

Expected output includes:
- `cuda available: True`
- RTX 50xx device listed

## Download models (optional)

```powershell
# PowerShell
./scripts/download-models.ps1 -outDir ./models -url https://example.com/path/to/sdxl-model.ckpt
```

```bash
# Bash
./scripts/download-models.sh ./models https://example.com/path/to/sdxl-model.ckpt
```

## Notes
- Do not commit model weights — `.gitignore` excludes `models/`, `output/`, `checkpoints/`.
- Keep `docs/COMFYUI_TODO.md` unchanged; unfinished items remain visible.
- Optional CI workflow provided under `.github/workflows/build-and-push.yml`.
