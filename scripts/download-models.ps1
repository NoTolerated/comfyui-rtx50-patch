param(
  [string]$outDir = "./models",
  [string]$url = "https://example.com/path/to/sdxl-model.ckpt"
)
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }
$fname = Split-Path $url -Leaf
$out = Join-Path $outDir $fname
Write-Host "Downloading $url -> $out"
Invoke-WebRequest -Uri $url -OutFile $out
Write-Host "Downloaded to $out"
