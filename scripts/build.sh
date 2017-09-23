#!/usr/bin/env bash
set -eo pipefail

mkdir -p dist

build() {
  basename="${1##*/}"
  output="dist/${basename%.md}.html"
  pandoc \
    --to=revealjs \
    --smart \
    --output="$output" \
    --standalone \
    --variable=theme:simple \
    "$1"
  echo "$1 -> $output"
}

[[ "$1" == "--watch" && $# -eq 4 ]] && build "$2$4" || \
  for file in src/*.md; do build "$file"; done

cp src/*.pdf dist

cd dist

../node_modules/.bin/indexifier --html . > index.html

echo "talks.tlvince.com" > CNAME

[[ -L reveal.js ]] || {
  [[ $CI ]] && cmd="cp -r" || cmd="ln -s"
  $cmd ../node_modules/reveal.js .
}
