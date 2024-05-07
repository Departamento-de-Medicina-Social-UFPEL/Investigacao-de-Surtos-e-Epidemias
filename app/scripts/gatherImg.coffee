
request = require 'request'
url = require 'url'
async = require 'async'
fs = require 'fs'
_ = require 'underscore'
path = require 'path'

module.exports = (caso, cb)->
  # console.log caso._id
  # console.log caso.titulo
  if caso.editores.length is 0
    return cb(null,[])
  imgGraber = (imgs, slide)->
    # console.log slide
    imgRegex = /<?(.|\n)img[^>]*src=\\?['"]\.?\/?([^'"]*?)\\?['"][^\/]*\/?>/img
    lot = []
    if slide.pergunta
      busca3 = slide.pergunta.match imgRegex
      lot = lot.concat busca3 if busca3
    for campo, cont of slide.conteudo
      if typeof cont is 'string'
        # console.log cont
        busca = cont.match imgRegex
        lot = lot.concat busca if busca
      if typeof cont is 'object'
        if typeof cont.texto is 'string'
          # console.log cont
          busca = cont.texto.match imgRegex
        else if typeof cont.conteudo is 'string'
          # console.log cont
          busca = cont.conteudo.match imgRegex
      lot = lot.concat busca if busca
    lot = lot.map (i)->
      i.match(/src=['"]\.?\/?([^'"]*?)['"]/im).slice(-1)
    lot = _.flatten lot
    return imgs.concat lot

  allImgs = caso.slides.reduce(imgGraber, []).filter (a)-> Boolean a
  # console.log allImgs
  imagens = _.uniq(allImgs)
  imagens.push 'img/fenoSprite.png'
  # console.log imagens

  mapper = (filename, nexter)->
    pathname = "/home/dev/static/public/#{filename}"
    fs.stat pathname, (err, stat)->
      if err
        # throw 
        return nexter """|Erro Img:|Caso: #{caso.id} - #{caso.titulo}|Path: #{pathname}"""
      {size} = stat
      return nexter null, {size, pathname, filename}

  deu = (err, mapped)->
    console.log err if err
    # throw err if err
    cb(err, mapped.filter (a)-> Boolean a)

  async.map imagens, mapper, deu
