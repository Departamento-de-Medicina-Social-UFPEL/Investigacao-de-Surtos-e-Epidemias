
editores = []
autores = []
cleanUp = (s)-> s.toLowerCase().trim().replace(/\s{1,}/img, ' ')

_ = require 'underscore'
diff = (A, B)-> _.filter A, (obj)-> obj not in B
Caso = require '../models/caso.coffee'
Selecao = require '../models/selecao.coffee'


Selecao
.findOne _id: '59a863f941e46f6934f37a1e'
.populate 'casos'
.exec (err, seleca)->
  throw err if err
  {casos} = seleca
  bibs = []
  casos.forEach (c) ->
    slides = c['slides']
    cont = slides.filter((s) ->
      s.tipo == 'bibliografia'
    )[0].conteudo
    warn = false
    cont.forEach (b) ->
      if b.linkTitulo.length < 1
        warn = true
      return
    if warn
      console.log c
    bibs = [].concat(bibs, cont)
    return
  console.log bibs
