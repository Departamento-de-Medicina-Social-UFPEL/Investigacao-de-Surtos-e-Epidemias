Biblio = require '../models/bibliografia.coffee'
Selecao = require '../models/selecao.coffee'
_ = require 'lodash'
arr = []

_id = process.argv[2]

Selecao
.findOne {_id}
.populate 'casos'
.exec (err, sel)->
  throw err if err
  i = 1
  for caso in sel.casos
    {slides} = caso
    biblio = slides.filter((s)-> s.tipo is  'bibliografia')[0]
    arr = arr.concat biblio.conteudo.map (bib)-> 
      bib['caso'] = caso._id
      bib['casoId'] = caso.id
      bib['caso_titulo'] = caso.titulo
      if bib.linkTitulo isnt ""
        bib['chave'] = bib.linkTitulo.trim().toLowerCase().replace(/[\s.,:)(]/g,"").replace(/[aáàãâä]/g,"a").replace(/[éèê]/g,"e").replace(/[íì]/g,"i").replace(/[óòõ]/g,"o").replace(/[úù]/g,"u")
        bib['serial'] = i
        i++
      bib
    # JSON.stringify(bib, null, 3) #+ '\n\n'
  # for a in arr
  console.log arr
  arr = _.uniq arr, (a)->
    a.chave
  arr.forEach (item) ->
  	# console.log item, 'item', item.linkTitulo isnt ""
  	if item.linkTitulo isnt ""
      nI = new Biblio()
      nI.autor = ""
      nI.serial = item.serial
      nI.casoId = item.casoId
      nI.caso_titulo = item.caso_titulo
      nI.caso = item.caso
      nI.chave = item.chave
      nI.ano = ""
      nI.filesize = ""
      nI.url = ""
      nI.urlOri = item.urlExterno.trim().toLowerCase()
      nI.titulo = item.linkTitulo.trim()
      if item.acessoEm
        nI.acessoEm = item.acessoEm.trim()
      nI.modulo = '59a0be22a8b9ce7531974290'
      # cond = {titulo:item.linkTitulo.trim()}, {urlOri:item.urlExterno.trim().toLowerCase()}];
      # Biblio.findOne({$or:cond}).exec (err, b)->
      Biblio.findOne({chave: item.chave}).exec (err, b)->
        if err
          throw err
        if not b
          do nI.save
	  	
#       console.log item[prop]
# {
#    "acessoEm": "nov. 2016",
#    "urlExterno": "http://www.febrasgo.org.br/site/wp-content/uploads/2013/05/Femina-v37n9_Editorial.pdf",
#    "urlLocal": "",
#    "linkTitulo": "POLI, M.E.H. et al. Manual de anticoncepção da FEBRASGO. <strong>Femina</strong>, v. 37, n. 9, p. 459-492, 2009. Disponível em: "
# }
#   nI.autor = item.autor.trim()
#   nI.ano = item.ano.trim()


