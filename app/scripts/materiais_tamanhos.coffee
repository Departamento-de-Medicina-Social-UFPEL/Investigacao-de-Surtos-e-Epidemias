Materiais = require '../models/materiais.coffee'
fs = require 'fs'
filesize = require './filesize.js'

getFilesizeInBytes = (filename)->
  stats = fs.statSync filename
  fileSizeInBytes = stats['size']

Materiais.find({modulo: '5d8aab26afcdb9691fbbfdc0'}).exec (err, docs)->
  for doc in docs
  	if doc.get('tipo') isnt 'video' 
	    size = getFilesizeInBytes "/home/dev/static/public/bib/apoio/#{doc.url}"
	    strOpt = { base: 2, round: 1 }
	    strSize = filesize size, strOpt
	    doc.filesize = strSize
	    console.log doc.filesize
	    do doc.save
