#!/usr/bin/env bash
set -euo pipefail
OUT_DIR="${1:-./models}"
URL="${2:-https://example.com/path/to/sdxl-model.ckpt}"
mkdir -p "$OUT_DIR"
FNAME="$(basename "$URL")"
OUT="$OUT_DIR/$FNAME"
echo "Downloading $URL -> $OUT"
curl -L "$URL" -o "$OUT"
echo "Downloaded to $OUT"
