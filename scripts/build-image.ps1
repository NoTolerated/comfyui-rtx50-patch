# Build ComfyUI RTX 5070 Image
# This script builds the image in the background and monitors progress

$ErrorActionPreference = "Stop"
$buildContext = "c:\Users\mrsim\Documents\GitHub\NoTolerated-Web-Project\comfyui-rtx50-patch"
$dockerfile = "$buildContext\docker\comfyui\Dockerfile.gpu"
$imageName = "comfyui-rtx50:local"

Write-Host "Starting ComfyUI RTX 5070 build..." -ForegroundColor Cyan
Write-Host "Dockerfile: $dockerfile" -ForegroundColor Gray
Write-Host "Context: $buildContext" -ForegroundColor Gray
Write-Host "Image: $imageName" -ForegroundColor Gray
Write-Host "`nThis will take 5-10 minutes..." -ForegroundColor Yellow
Write-Host "Press Ctrl+C to cancel`n" -ForegroundColor Gray

# Start build
docker build -f $dockerfile -t $imageName $buildContext

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✓ Build completed successfully!" -ForegroundColor Green
    Write-Host "`nNext steps:" -ForegroundColor Cyan
    Write-Host "  1. Test GPU: .\comfyui-rtx50-patch\scripts\test-gpu-windows.ps1" -ForegroundColor White
    Write-Host "  2. Update compose: See docs\COMFYUI_MIGRATION_PLAN.md" -ForegroundColor White
    exit 0
} else {
    Write-Host "`n✗ Build failed with exit code $LASTEXITCODE" -ForegroundColor Red
    Write-Host "Check logs above for errors" -ForegroundColor Yellow
    exit 1
}
