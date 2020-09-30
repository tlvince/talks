#!/usr/bin/env bash
set -eo pipefail

build() {
  basename="${1##*/}"
  basename="${basename%.md}"
  output="dist/${basename}.html"
  pandoc \
    --to=revealjs \
    --output="$output" \
    --standalone \
    --variable=history:true \
    --variable=revealjs-url:/reveal.js \
    "$1"
  echo "$1 -> $output"
}

# Fast watch mode
[[ "$1" ]] && {
  build "$1"
  [[ -L dist/reveal.js ]] && exit
  cd dist
  ln -s "../node_modules/reveal.js" .
  ln -s "../src/images" .
  exit
}

for file in src/*.md; do build "$file"; done
cd dist
../node_modules/.bin/indexifier --html . | grep -v 'href="./index.html"' > index.html
echo "talks.tlvince.com" > CNAME
cp -r ../node_modules/reveal.js .
cp -r ../src/images .
cp ../src/*.pdf .
