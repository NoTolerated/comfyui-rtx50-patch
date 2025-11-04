# scripts/download-models.ps1

**Status:** Documentation stub created 2025-11-01

## Overview

PowerShell script for downloading model files to a local directory.

## Location

`scripts/download-models.ps1`

## Usage

```powershell
./scripts/download-models.ps1 -outDir ./models -url https://example.com/path/to/sdxl-model.ckpt
```

## Parameters

- `outDir` — Output directory for downloaded models (default: `./models`)
- `url` — URL of the model file to download

## Behavior

1. Creates output directory if it doesn't exist
2. Extracts filename from URL
3. Downloads file using `Invoke-WebRequest`
4. Saves to `$outDir/$filename`

## Notes

- Model weights are excluded from git (see `.gitignore`)
- For Bash equivalent, see `scripts/download-models.sh`
- Verify model checksums/signatures before use in production

## Related

- [COMFYUI_GPU_COMPATIBILITY_ISSUE.md](../COMFYUI_GPU_COMPATIBILITY_ISSUE.md) — mentions download scripts
- [COMFYUI_TODO.md](../COMFYUI_TODO.md) — secure model download pipeline (TODO)

---

*This is a documentation stub. To complete: add examples, error handling notes, and checksum verification guidance.*
