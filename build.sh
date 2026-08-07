#!/usr/bin/env bash
# Runs on Render during deploy. Swaps the placeholders in index.html
# for the real values from Render's Environment tab, and writes the
# result into dist/ (the folder Render will publish).
set -e

mkdir -p dist

sed \
  -e "s#__SUPABASE_URL__#${SUPABASE_URL}#g" \
  -e "s#__SUPABASE_ANON_KEY__#${SUPABASE_ANON_KEY}#g" \
  index.html > dist/index.html

echo "Build complete: dist/index.html generated with live keys."
