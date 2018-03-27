#!/usr/bin/env bash
set -eo pipefail

npm run serve &

for file in $(ls dist/*.html); do
  basename="${file##*/}"
  [[ "$basename" == "index.html" ]] && continue
  ./node_modules/.bin/decktape --no-sandbox reveal "http://localhost:8000/$basename?showNotes=true" "dist/${basename%.html}.pdf"
done

kill %1
