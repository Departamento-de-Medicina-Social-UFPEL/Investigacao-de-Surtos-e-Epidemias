Biblio = require '../models/bibliografia.coffee'
fs = require 'fs'
filesize = require './filesize.js'

getFilesizeInBytes = (filename)->
  stats = fs.statSync filename
  fileSizeInBytes = stats['size']

Biblio.find({modulo: '5669C5C4F9D50797D4F3B497'}).exec (err, docs)->
  for doc in docs
    size = getFilesizeInBytes "/home/dev/static/public/bib/#{doc.url}"
    strOpt = { base: 2, round: 1 }
    strSize = filesize size, strOpt
    doc.filesize = strSize
    console.log doc.filesize
    do doc.save