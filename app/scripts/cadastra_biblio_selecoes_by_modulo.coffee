Biblio = require '../models/bibliografia.coffee'
Caso = require '../models/caso.coffee'
Modulo = require '../models/moduloModel.coffee'
Selecao = require '../models/selecao.coffee'
_ = require 'lodash'
arr = []

# arr = [
#   {
#     "ano": "2004"
#     "autor": "BRASIL. Ministério da Saúde. Secretaria de Atenção à Saúde. Instituto Nacional de Câncer."
#     "titulo": "TNM: classificação de tumores malignos."
#     "etc":"281p. 6 ed. Rio de Janeiro: INCA/UICC,"
#     "url": "TNM.pdf"
#   }
# ]

_id = process.argv[2]

Modulo.findOne({_id:_id}).lean().exec (err, m)->
  if err
    throw err
  componentes = m.components.filter (i)->
    return i.externalResources == true && i.ref == 'selecoes'
  ids = componentes.map (it)->
    it.oid
  Selecao.find({_id:{$in:ids}}).lean().exec (e, ss)->
    if e
      throw err
    casos = []
    ss.forEach (s)->
      casos = casos.concat s.casos
    console.log casos.length
    casos = _.uniq casos
    Caso.find({_id:{$in:casos}}).lean().exec (e,cs)->
      if e
        throw e
      console.log cs.length
      for caso in cs
        {slides} = caso
        biblio = slides.filter((s)-> s.tipo is  'bibliografia')[0]
        console.log('caso sem biblio grafia', caso._id) if not biblio
        continue if not biblio
        arr = arr.concat biblio.conteudo.map (bib)-> bib # JSON.stringify(bib, null, 3) #+ '\n\n'
      # console.log arr[0]
      arr.forEach (item) ->
        # console.log item, 'item', item.linkTitulo isnt ""
        if item.linkTitulo isnt ""
          nI = new Biblio()
          nI.autor = ""
          nI.ano = ""
          nI.filesize = ""
          nI.url = ""
          nI.urlOri = item.urlExterno.trim().toLowerCase()
          nI.titulo = item.linkTitulo.trim()
          if item.acessoEm
            nI.acessoEm = item.acessoEm.trim()
          nI.modulo = '59a0be22a8b9ce7531974290'
          Biblio.findOne({titulo:item.linkTitulo.trim()}).exec (err, b)->
            if err
              throw err
            if not b
              do nI.save



# Selecao
# .findOne {_id}
# .populate 'casos'
# .exec (err, sel)->
#   throw err if err
#   for caso in sel.casos
#     {slides} = caso
#     biblio = slides.filter((s)-> s.tipo is  'bibliografia')[0]
#     arr = arr.concat biblio.conteudo.map (bib)-> bib # JSON.stringify(bib, null, 3) #+ '\n\n'
#   console.log arr[0]
#   arr.forEach (item) ->
#   	# console.log item, 'item', item.linkTitulo isnt ""
#   	if item.linkTitulo isnt ""
#       nI = new Biblio()
#       nI.autor = ""
#       nI.ano = ""
#       nI.filesize = ""
#       nI.url = ""
#       nI.urlOri = item.urlExterno.trim().toLowerCase()
#       nI.titulo = item.linkTitulo.trim()
#       if item.acessoEm
#         nI.acessoEm = item.acessoEm.trim()
#       nI.modulo = '59a0be22a8b9ce7531974290'
#       Biblio.findOne({titulo:item.linkTitulo.trim()}).exec (err, b)->
#         if err
#           throw err
#         if not b
#           do nI.save
	  	
#       console.log item[prop]
# {
#    "acessoEm": "nov. 2016",
#    "urlExterno": "http://www.febrasgo.org.br/site/wp-content/uploads/2013/05/Femina-v37n9_Editorial.pdf",
#    "urlLocal": "",
#    "linkTitulo": "POLI, M.E.H. et al. Manual de anticoncepção da FEBRASGO. <strong>Femina</strong>, v. 37, n. 9, p. 459-492, 2009. Disponível em: "
# }
#   nI.autor = item.autor.trim()
#   nI.ano = item.ano.trim()


