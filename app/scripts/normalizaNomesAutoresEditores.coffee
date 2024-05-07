clusteredNomes = [
   [
      "Nádia Spada Fiori",
      "Nadia Spada Fiori",
      "Nádia Fiori"
   ]
]

cleanUp = (s)-> s.toLowerCase().trim().replace(/\s{1,}/img, ' ')
_ = require 'underscore'
async = require 'async'
Caso = require '../models/caso.coffee'

triaAutorEditores = (nomes, next)->
	oficialNome = nomes.shift()
	errados = nomes
	console.log """
-----------------
	#{oficialNome}
	#{JSON.stringify(errados,null, 3)}

"""
	Caso
	.find
		$or: [
			{ autor: $in: errados }
			{ editores: $in: errados }
		]
	.exec (err, docs)->
		throw err if err
		
		innerLoop = (caso, prox)->
			console.log """

			#{caso.titulo}
			"""
			console.log caso.autor, caso.editores
			caso.autor = caso.autor.split(',') unless _.isArray caso.autor
			caso.autor = for autor in caso.autor
				unless autor in errados then autor else oficialNome
			caso.editores = for editor in caso.editores
				unless editor in errados then editor else oficialNome
			console.log caso.autor, caso.editores
			caso.save ()->
				prox null
		
		innerEnd = ->
			next null

		async.eachSeries docs, innerLoop, innerEnd


# fim = -> console.log 'Terminei'

async.eachSeries clusteredNomes, triaAutorEditores, ()-> console.log arguments

# Caso
# .find shortname: {'$exists': yes} 
# .exec (e, casos)->
#   throw e if e
#   relevantes = casos.filter (caso)-> cleanUp(caso.titulo) in titulos
#   for caso in relevantes
#   	autores = autores.concat [].concat caso.autor
#   	editores = editores.concat [].concat caso.editores
#   	# console.log """

#   	# CASO: #{caso.titulo} (#{caso._id})
#   	# 	Núcleo: #{caso.profissional}
#   	# 	Editores: #{caso.editores}

#   	# """
#   # console.log casos.map (c)-> {_id: c._id, titulo: c.titulo}
#   naoAchou = diff(titulos, _.pluck(relevantes, 'titulo').map cleanUp)
#   # console.log naoAchou
#   for perdido in naoAchou
#   	require '../models/caso.coffee'
#   	.findOne titulo: perdido 
#   	.exec (err, caso)->
#   		# console.log caso
#   console.log _.uniq([].concat editores, autores).sort()



# Caso
# .findOne autor: 'Luz FB, Barbieri S, Pinto LR, Etges A'
# .exec (err, doc)->
# 	throw err if err
# 	return unless doc
# 	doc.autor = [
# 		'Felipe Brunatto da Luz'
# 		'Silene Barbieri'
# 		'Luciana de Rezende Pinto'
# 		'Adriana Etges'
# 	]
# 	doc.save(-> console.log arguments)
# 	console.log doc.titulo


# Caso
# .find { autor: $type: 4 }
# .exec (err, docs)->
# 	throw err if err
# 	return unless docs
# 	console.log _.pluck docs, 'titulo'


