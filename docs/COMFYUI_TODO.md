# ComfyUI TODO List

## UNFINISHED TODOS

These items are **not complete** and must remain visible in the repository and PRs.

### Integration & Testing

- [ ] Full end-to-end ComfyUI inference smoke with SDXL real prompt — validate output quality /
      speed & memory.
- [ ] Add automated nightly build matrix (test different CUDA/toolkit combos).
- [ ] Add reproducible small sample prompt & expected image sample for CI smoke (CPU-friendly).
- [ ] Add ai-reports/comfyui/ auto-log writer for build/test outputs (script to append logs).

### Performance & Optimization

- [ ] Add accelerate offload config and test CPU/GPU mixed offload for larger models.
- [ ] Integrate xformers/bitsandbytes if desired — test compatibility and GPU kernels.

### Security & Content

- [ ] Add secure model download pipeline: verify checksums / signatures.
- [ ] Add gating for content moderation / watermark metadata before generating images for monetized
      features.

### Observability

- [ ] Add telemetry/usage counters for ComfyUI usage via ai-router/tools (opt-in).

### Documentation & Process

- [ ] Add license & contributor guide; confirm MIT is OK with upstream license constraints.
- [ ] Add PR template that reminds maintainers to update COMPATIBILITY.md and docs/COMFYUI_TODO.md.

## Notes

- **DO NOT** auto-close or remove items from this list without completing them.
- Add new unfinished items here when discovered during development.
- Link to issues/PRs tracking each item when work begins.

### Model manifest + install (reference)

See `docs/VLM_MANIFEST.md` for the `.models/manifest.json` format and scripts under
`scripts/models/` to download and verify models. Containers should mount your shared models
directory (e.g. `/srv/models`) and set `VLM_MODELS_DIR` accordingly. This note does not change or
close any unfinished TODOs above.

## Completed Items

Move completed items here with completion date and PR link:

- [x] 2025-11-01: Created RTX50 Dockerfile and smoke test script (PR #xxx)
- [x] 2025-11-01: Added GPU compatibility docs (PR #xxx)
