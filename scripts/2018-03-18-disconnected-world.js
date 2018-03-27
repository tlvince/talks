#!/usr/bin/env node

const {
  readFile,
  writeFile
} = require('fs')

const {
  promisify
} = require('util')

const cheerio = require('cheerio')

const readFileP = promisify(readFile)
const writeFileP = promisify(writeFile)

// Workaround for https://github.com/jgm/pandoc/issues/4498
;(async () => {
  const path = './dist/2018-03-18-disconnected-world.html'
  const html = await readFileP(path)
  const $ = cheerio.load(html)
  $('#title-slide').attr('data-background-image', '/images/kano-dala-hill.jpg')
  const updatedHtml = $.html()
  await writeFileP(path, updatedHtml)
})()
