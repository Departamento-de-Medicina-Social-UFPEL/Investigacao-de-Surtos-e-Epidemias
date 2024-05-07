Progressos = require '../app/models/progressos.coffee'
async = require 'async'

criaUm = (um, callback)->
	p = new Progressos(um)
	p.save (err)->
		if err
			return callback err
		return  callback null, um

ffim = (err, result)->
	console.log("fim", result.length, err)

dt_atual = (new Date()).getTime()


cpfErrado = 'xxxxxx'
cpfCerto = 'yyyyyy'
moduloId = 'sassasas'

# Progressos.find({modulo:moduloId, ativo:true, cpf: cpfErrado}).exec (err, respostas)->
# 	if err
# 		throw err

# 	novasRespostas = respostas.map (r)-> 
# 		delete r._id
# 		r.user = cpfCerto
# 		r.ts = dt_atual

# 	Progressos.update {modulo:moduloId, ativo:true, cpf: cpfCerto}, {$set:{ativo:false}}, {multi:true}, (err, numRows)->
# 		if err
# 			throw err

# 		async.map novasRespostas, criaUm, ffim
