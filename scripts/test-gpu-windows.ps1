# ComfyUI RTX 5070 Quick Test Script
# Tests GPU detection and basic PyTorch functionality

Write-Host "=== ComfyUI RTX 5070 GPU Test ===" -ForegroundColor Cyan

# Test 1: Check host GPU
Write-Host "`n[1/4] Checking host GPU..." -ForegroundColor Yellow
try {
    $gpuInfo = nvidia-smi --query-gpu=name,driver_version --format=csv,noheader
    Write-Host "✓ GPU Detected: $gpuInfo" -ForegroundColor Green
} catch {
    Write-Host "✗ NVIDIA driver not found. Install NVIDIA drivers first." -ForegroundColor Red
    exit 1
}

# Test 2: Check Docker GPU access
Write-Host "`n[2/4] Checking Docker GPU access..." -ForegroundColor Yellow
try {
    $dockerGpu = docker run --rm --gpus all nvidia/cuda:12.6.0-base-ubuntu22.04 nvidia-smi --query-gpu=name --format=csv,noheader 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Docker can access GPU: $dockerGpu" -ForegroundColor Green
    } else {
        Write-Host "✗ Docker cannot access GPU. Install NVIDIA Container Toolkit." -ForegroundColor Red
        Write-Host "  Error: $dockerGpu" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "✗ Docker GPU test failed: $_" -ForegroundColor Red
    exit 1
}

# Test 3: Check if ComfyUI image exists
Write-Host "`n[3/4] Checking ComfyUI image..." -ForegroundColor Yellow
$imageExists = docker images -q comfyui-rtx50:local
if ($imageExists) {
    Write-Host "✓ Image 'comfyui-rtx50:local' found" -ForegroundColor Green
} else {
    Write-Host "✗ Image 'comfyui-rtx50:local' not found. Build it first:" -ForegroundColor Red
    Write-Host "  cd comfyui-rtx50-patch" -ForegroundColor Yellow
    Write-Host "  docker build -f docker\comfyui\Dockerfile.gpu -t comfyui-rtx50:local ." -ForegroundColor Yellow
    exit 1
}

# Test 4: Test PyTorch CUDA in container
Write-Host "`n[4/4] Testing PyTorch CUDA in container..." -ForegroundColor Yellow
$testScript = @"
import torch
import sys
print(f'PyTorch version: {torch.__version__}')
print(f'CUDA available: {torch.cuda.is_available()}')
if torch.cuda.is_available():
    print(f'CUDA version: {torch.version.cuda}')
    print(f'Device count: {torch.cuda.device_count()}')
    print(f'Device name: {torch.cuda.get_device_name(0)}')
    # Quick tensor test
    x = torch.randn(1000, 1000).cuda()
    y = torch.randn(1000, 1000).cuda()
    z = x @ y
    print(f'Matrix multiply test: PASSED')
    sys.exit(0)
else:
    print('ERROR: CUDA not available in container')
    sys.exit(1)
"@

try {
    $tempFile = [System.IO.Path]::GetTempFileName()
    $testScript | Out-File -FilePath $tempFile -Encoding utf8 -NoNewline
    
    $result = docker run --rm --gpus all -v "${tempFile}:/test.py:ro" comfyui-rtx50:local python /test.py 2>&1
    Remove-Item $tempFile
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host $result -ForegroundColor Green
        Write-Host "`n✓ All tests passed! ComfyUI is ready for RTX 5070." -ForegroundColor Green
        Write-Host "`nNext steps:" -ForegroundColor Cyan
        Write-Host "  1. Start ComfyUI: docker compose -f docker-compose.ai-stack.yml up -d comfyui" -ForegroundColor White
        Write-Host "  2. Access UI: http://localhost:8188" -ForegroundColor White
        Write-Host "  3. Download models: .\comfyui-rtx50-patch\scripts\download-models.ps1" -ForegroundColor White
        exit 0
    } else {
        Write-Host $result -ForegroundColor Red
        Write-Host "`n✗ PyTorch CUDA test failed" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "✗ Container test failed: $_" -ForegroundColor Red
    exit 1
}
