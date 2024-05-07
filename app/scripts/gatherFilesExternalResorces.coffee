Selecao = require '../models/selecao.coffee'
Bibliografia = require '../models/bibliografia.coffee'
Materiais = require '../models/materiais.coffee'
Casos = require '../models/caso.coffee'
_ = require 'underscore'
async = require 'async'
fs = require 'fs'
path = require('path')
url = require('url')
request = require('request')
pub = '../../public'
pub = path.resolve(__dirname, pub)
PPUsRootFolder = path.resolve(__dirname, '../../public/ppu/modulos/')
cascaBuildFolder = path.resolve(__dirname, "../../ppu/template_calculadoras")
gatherImg = require './gatherImg.coffee'
gatherBiblio = require './gatherBiblio.coffee'
module.exports = (modulo, cb, flag_apenas_local = false)->
	destino = getFolder(modulo)
	console.log 'conferindo components... ', modulo.components.length
	iterator = (item, next) ->
		return next(null, item) unless item.externalResources is true
		# console.log item.ref
		DBModel = switch item.ref
			when 'selecoes'
				Selecao
			when 'bibliografias'
				Bibliografia
			when 'materiais'
				Materiais
			when 'casos'
				Casos
		query = {}
		query = '_id': item.oid if item.oid
		query = item.match if item.match
		Qry = DBModel.find query
		if item.ref is 'selecoes'
			Qry.populate path: 'casos', options: lean: true
		do Qry.lean
		Qry.exec (err, docs) ->
			throw err if err
			item.resource = docs
			item.resource = docs[0] if item.ref is 'selecoes'
			next(null, item)
	finalize = (err, comps) ->
		throw err if err
		console.log 'componentes consultados'
		mapper = (comp, nexter)->
			if not comp.externalResources
				return nexter(null, comp)
			console.log(comp.ref, 'mais um comp', comp.ref)
			if comp.ref is 'selecoes'
				#"folder" : "unidade-progresso"
				#"folder" : "video-player"
				console.log(comp.folder, 'mais um comp com selecao')
				if comp.folder is 'unidade-progresso'
					console.log 'gatherArquivosUnidade'
					return gatherArquivosUnidade(comp, destino, nexter)
				else
					console.log 'gatherArquivosSelecao'
					return gatherArquivosSelecao(comp, destino, nexter)
			else
				console.log 'gatherArquivosOutros'
				return gatherArquivosOutros(comp, destino, nexter, true)
		deu = (err, mapped)->
			console.log err, 'arquivos buscados'
			# throw err if err
			return cb err, mapped.filter((a) ->
				Boolean a
			)
		if (!fs.existsSync(destino))
			fs.mkdirSync(destino, '755')
		async.map comps, mapper, deu
	async.map modulo.components, iterator, finalize
#verifica e busca arquivos de uma unidade (videos e casos)
gatherArquivosUnidade = (comp, dest, next)->
	console.log 'verificando arquivos '+comp.folder+' ... /n', comp.resource.length
	if comp.sources
		itens = comp.sources.map (s)->
			s.urlInterna = '../../videos/'+s.filename+'_'+s.resolution+'.'+s.extension
			return s
	else 
		itens = comp.resource 
	files = itens.map (f)->
		if f.filename.indexOf('apoio/') > -1
			f.destino = dest+'assets/bib/'+f.filename
		else
			f.destino = dest+'assets/bib/apoio/'+f.filename
		return f
	console.log files, "arquivos unidades"
	return moveArquivosParaBib files,(err, files)=> 
		console.log 'callback unidade, a buscar arquivos selecao'
		return gatherArquivosSelecao(comp, dest, next)

#verifica e busca arquivos de uma selecao de casos clinicos
gatherArquivosSelecao = (comp, dest, next)->
	console.log 'pegando arquivos de uma seleção .../n'
	buscaArquivosUmCaso = (caso,call_caso)->
		#console.log 'mais um caso'
		return gatherImg caso, (err, imagens)->
			return call_caso(err) if err 
			console.log imagens.length + ' imagens encontradas para o caso: '+caso.id
			imagens = imagens.map (i)->
				if i.filename.indexOf('img/') > -1
					i.filename = i.filename.substring(4)
				i.destino = dest+'assets/images/'+i.filename
				i.caso = caso
				return i
			return gatherBiblio caso, (err, biblios) ->
				return call_caso(err) if err
				biblios = biblios.map (b)->
					if b.filename.indexOf('apoio/') > -1
						b.destino = dest+'assets/bib/'+b.filename
					else
						b.destino = dest+'assets/bib/apoio/'+b.filename
					b.caso = caso
					return b
				files = imagens.concat biblios
				console.log biblios.length + ' bibliografias encontradas para o caso: '+caso.id
				return moveArquivosParaBib files, (err, arquivosbibs)=>
					return call_caso(err) if err
					console.log 'Todos as bibliografias do caso: '+caso.id+' foram movidos'
					return call_caso(null, arquivosbibs)	
	final_caso = (err, arquivos)->
		console.log arquivos.length + ' arquivos encontrados na selacao! e movidos2!'
		return next(err) if err
		return next(null, comp)
	console.log "======================== filtar casos"
	casos = comp.resource.casos.filter (c)->
		return c.posTeste is undefined
	console.log "======================== casos filtrados+=================="
	if casos.length is 0
		return next(null)
	console.log "======================== byscando arquivos de um caso +=================="
	return async.map casos, buscaArquivosUmCaso, final_caso

#verifica todos os arquivos de um componentes comum, lista de arquivos
gatherArquivosOutros = (comp, dest, next, flag_apenas_local)->
	console.log 'verificando arquivos '+comp.folder+' ... /n', comp.resource.length
	buscaArquivoComun = (bib, nextor) ->
		urlInterna = bib.urlLocal || bib.url
		# console.log bib, "<========= bib"
		if urlInterna
			# console.log 'O arquivo existe localmente: '+urlInterna+' /n'
			return nextor( null,
				pathname: '/home/dev/static/public/bib/apoio/' + urlInterna
				filename: urlInterna
				size: '0')
		else
			if flag_apenas_local
				return nextor(null, "Não existe arquivo local ")
			if !/\.pdf/gim.test(bib.urlExterno)
				bib.urlExterno = bib.urlOri
			if !/\.pdf/gim.test(bib.urlExterno)
				console.log '==================erro sem url ============', bib
				return nextor("Não existe url local nem externa para o arquivo: "+ bib.titulo)
			b = bib.urlExterno
			if !/https?:\/\//gim.test(b)
				console.log 'ATENCÃO: Link ' + b + ' não possui protocolo. Tentando http://'
				b = 'http://' + b
			url = require('url')
			link = url.parse(b)

			b = b.replace(/\/n/g,"")
			loc = path.parse(link.pathname)
			options =
				method: 'HEAD'
				url: b.replace(/\/n/g,"")
				headers: 'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36'
				followAllRedirects: true
			request options, (err, r) ->
				headers = undefined
				mime = undefined
				size = undefined
				status = undefined
				if not r
					return nextor(null, "Erro ao requisitar a url: "+options.url)
				headers = r.headers
				mime = headers['content-type']
				size = headers['content-length']
				status = r.statusCode
				msgerro = bib.titulo + ' ' + bib._id
				if status == 200 and (mime.indexOf('application/pdf') or mime.indexOf('application/save'))
					return fs.stat('/home/dev/static/public/bib/apoio/' + loc.base, (err, stat) ->
						if !err
							size = stat.size
							return nextor(null,{ pathname: '/home/dev/static/public/bib/apoio/' + loc.base, filename: loc.base, size: size})
						options =
							method: 'GET'
							url: b
							headers: 'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36'
							followAllRedirects: true
						#nao tem local, busca
						request options, (err, res, body) ->
							if err
								msg = "Erro request bibliografia: "+ b
								console.log msg
								return nextor(null, msg) 
								#return nextor("Erro request bibliografia: "+ b, { pathname: '/home/dev/static/public/bib/apoio/' + loc.base, filename: loc.base, size: size})
							headers = r.headers
							mime = headers['content-type']
							size = headers['content-length']
							status = r.statusCode
							#console.log 'saving file: /home/dev/static/public/bib/apoio/' + loc.base
							#escreve o arquivo na pasta de destino
							arq = '/home/dev/static/public/bib/apoio/' + loc.base
							fs.writeFile arq, body, (err) ->
								if err
									return nextor("Error ao escrever arquivo bib na pasta destino ".b, null)
								return nextor null, {pathname: arq, filename: loc.base, size: size}
					)
				else if status != 200
					console.log "arquivo nao encontrado: ", status, options.url
					return nextor(null,'ERRO: Arquivo ' + b + ' não encontrado. status ' + status )
				else if mime != 'application/pdf'
					console.log 'arquivo não é pdf: ', mime, b
					return nextor(null,'ERRO: Arquivo ' + b + ' não é PDF. status ' + mime)
				return nextor(null, 'ERRO: Arquivo ' + bib.titulo + ' não possui url ')
		#console.log(bib)
		#return nextor('ERRO: Arquivo ' + bib.titulo + ' não possui url ')
	final_arquivo_comun = (err, mapped) ->
		return next(err) if err
		console.log mapped.length+' arquivos encontrados'
		files = mapped.map (f)->
			if typeof(f) is 'string'
				return false
			if f.filename.indexOf('apoio/') > -1
				f.destino = dest+'assets/bib/'+f.filename
			else
				f.destino = dest+'assets/bib/apoio/'+f.filename
			return f
		files = files.filter (f)-> f
		console.log 'movendo arquivos comuns para lib'
		return moveArquivosParaBib files, next
	if comp.sources
		itens = comp.sources.map (s)->
			s.urlInterna = '../../videos/'+s.filename+'.'+s.extension
			return s
	else 
		itens = comp.resource 
	itens = itens.filter (v)-> v.tipo isnt 'video'
	if comp.ref is 'bibliografias'
		itens = itens.filter (b)-> 
			url = b.url or b.urlOri or b.urlExterno
			return (url and /\.pdf/gim.test(url))
	async.map itens, buscaArquivoComun, final_arquivo_comun

#move todos os arquivos para o destino bib, retorna error caso algum de problema
moveArquivosParaBib = (arquivos, finalMover)=>
	# console.log 'movendo '+arquivos.length+' para a pasta :'+bib+' /n'
	# console.log arquivos, finalMover, 'final final'
	copiaUm = (arq, cb_copy)->
		origin = arq.pathname
		dest = arq.destino
		if !fs.existsSync(arq.pathname)
			arq.caso = null
			arq.pathname = arq.pathname.replace(/apoio\//g,"")
			if !fs.existsSync(arq.pathname)
				console.log("Arquivo local não existe: ",arq)
				return cb_copy null, false
		dir_dest = path.dirname(dest)
		if !fs.existsSync(dir_dest)
			fs.mkdirSync(dir_dest, {recursive:true})
		fs.createReadStream(origin).pipe(fs.createWriteStream(dest)
			.on 'error', (err) ->
				console.log 'Error: ', err, arq
				return cb_copy "Ocorreu um erro ao copiar arquivo local("+arq.filename+"): "+origin+' para '+dest
			.on 'finish', ()->
				#console.log('copiado')
				return cb_copy null, arq
		)
	tentouCopiarTodos = (err, arquivos)->
		if err
			console.log 'alguns arquivos não puderam ser copiados: ', err
			return finalMover(err, null)
		return finalMover(null, arquivos.filter (a)-> Boolean a)
	#console.log arquivos
	async.map arquivos, copiaUm, tentouCopiarTodos

#retorna o nome da pasta
getFolder = (modulo, zip = false)->
    console.log 'getFolder external files', modulo.name
    if modulo.name.indexOf('Calc') > -1
      short = "calculadora-#{modulo.shortname}"
    else
      short = "modulo-#{modulo.shortname}"
    namespace = short.toUpperCase().replace /[^A-Z]*/img, ''
    ns = "UFPEL_0001_#{namespace}"
    if not zip
      folder = "#{PPUsRootFolder}/#{ns}/"
    else
      folder = "#{PPUsRootFolder}/#{ns}.zip"
    folder
	