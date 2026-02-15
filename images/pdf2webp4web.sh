#!/usr/bin/env bash
set -euo pipefail

# Usage: pdf2web.sh input.pdf
# Output:
#   single page  -> input.webp
#   multi-page   -> input-01.webp, input-02.webp, ...

if [[ $# -ne 1 ]]; then
  echo "Usage: $(basename "$0") input.pdf"
  exit 1
fi

input="$1"

if [[ ! -f "$input" ]]; then
  echo "Error: File not found: $input"
  exit 1
fi

base="$(basename "$input" .pdf)"
tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

echo "Rendering PDF (high-quality vector render)..."

# Render to high-quality PNG first (best intermediate for line art)
gs -dSAFER -dBATCH -dNOPAUSE \
   -sDEVICE=png16m \
   -r400 \
   -dTextAlphaBits=4 \
   -dGraphicsAlphaBits=4 \
   -sOutputFile="$tmpdir/page-%03d.png" \
   "$input"

count=$(ls "$tmpdir"/page-*.png | wc -l | tr -d ' ')

echo "Trimming whitespace and converting to lossless WebP..."

convert_page () {
  local in="$1"
  local out="$2"

  magick "$in" \
    -colorspace Gray \
    -fuzz 1% -trim +repage \
    -define webp:lossless=true \
    -define webp:method=6 \
    -strip \
    "$out"
}

if [[ "$count" -eq 1 ]]; then
  convert_page "$tmpdir/page-001.png" "${base}.webp"
  echo "Created ${base}.webp"

else
  i=1
  for f in "$tmpdir"/page-*.png; do
    printf -v num "%02d" "$i"
    convert_page "$f" "${base}-${num}.webp"
    ((i++))
  done
  echo "Created ${base}-NN.webp files ($count pages)"
fi

