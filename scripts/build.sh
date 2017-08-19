#!/usr/bin/env bash
set -eo pipefail

mkdir -p dist

for file in src/*.md; do
  basename="${file##*/}"
  output="dist/${basename%.md}.html"
  pandoc \
    --to=revealjs \
    --smart \
    --output="$output" \
    --standalone \
    --variable=theme:simple \
    "$file"
  echo "$file -> $output"
done

cd dist

../node_modules/.bin/indexifier --html . > index.html

echo "talks.tlvince.com" > CNAME

[[ -L reveal.js ]] || {
  [[ $CI ]] && cmd="cp -r" || cmd="ln -s"
  $cmd ../node_modules/reveal.js .
}
