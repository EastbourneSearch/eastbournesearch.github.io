#!/usr/bin/env bash
set -euo pipefail

# Usage: pdf2jpg.sh input.pdf
# Outputs: input.jpg (single page) OR input-01.jpg, input-02.jpg, ...

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

echo "Rendering PDF at high resolution..."

# High-quality render to temporary JPEGs
gs -dSAFER -dBATCH -dNOPAUSE \
   -sDEVICE=jpeg \
   -r300 \
   -dJPEGQ=95 \
   -sOutputFile="$tmpdir/page-%03d.jpg" \
   "$input"

count=$(ls "$tmpdir"/page-*.jpg | wc -l | tr -d ' ')

echo "Trimming whitespace and optimizing..."

if [[ "$count" -eq 1 ]]; then
  magick "$tmpdir/page-001.jpg" \
    -fuzz 2% -trim +repage \
    -colorspace sRGB \
    -sampling-factor 4:2:0 \
    -strip \
    -interlace Plane \
    -quality 95 \
    "${base}.jpg"

  echo "Created ${base}.jpg"

else
  i=1
  for f in "$tmpdir"/page-*.jpg; do
    printf -v num "%02d" "$i"

    magick "$f" \
      -fuzz 2% -trim +repage \
      -colorspace sRGB \
      -sampling-factor 4:2:0 \
      -strip \
      -interlace Plane \
      -quality 95 \
      "${base}-${num}.jpg"

    ((i++))
  done

  echo "Created ${base}-NN.jpg files ($count pages)"
fi

