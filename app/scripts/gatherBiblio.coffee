async = undefined
fs = undefined
path = undefined
request = undefined
url = undefined
request = require('request')
url = require('url')
async = require('async')
fs = require('fs')
path = require('path')

module.exports = (caso, cb, flag_apenas_local = false) ->
  bibs = undefined
  components = undefined
  deu = undefined
  mapper = undefined
  slideBib = undefined
  components = caso.components
  slideBib = caso.slides.filter((c) ->
    c.tipo == 'bibliografia'
  )[0]
  if caso.editores.length is 0
    return cb(null,[])
  try
    bibs = slideBib.conteudo
  catch e
    console.log caso
    return cb("bibliografia mau formado no caso clinico :"+caso.id)
  mapper = (bib, nextor) ->
    b = undefined
    urlInterna = undefined
    link = undefined
    loc = undefined
    options = undefined
    # console.log bib, "<========= bib"
    # console.log bib, 'bib'
    
    urlInterna = bib.urlLocal
    if not urlInterna
      urlInterna = ''
    # console.log bib, "<========= bib"
    if not urlInterna or urlInterna.length is 0 
      b = bib.urlExterno
      if b
        link = url.parse(b)
        loc = path.parse(link.pathname)
        if not loc.base
          return nextor null, false
        if fs.existsSync('/home/dev/static/public/bib/' + loc.base)
          urlInterna = loc.base
        if fs.existsSync('/home/dev/static/public/bib/apoio/' + loc.base)
          urlInterna = 'apoio/' + loc.base
    if urlInterna.length > 0
      return nextor( null, { pathname: '/home/dev/static/public/bib/' + urlInterna, filename: urlInterna, size: '0'})
    else
      if flag_apenas_local
        return nextor(null, "Não existe arquivo local ")
      if !/\.pdf/gim.test(bib.urlExterno)
        return nextor(null)
      if !/https?:\/\//gim.test(b)
        console.log 'ATENCÃO: Link ' + b + ' não possui protocolo. Tentando http://'
        b = 'http://' + b
      b = b.replace(/\/n/g,"")
      options =
        method: 'HEAD'
        url: b
        headers: 'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36'
        followAllRedirects: true
      request options, (err, r) ->
        headers = undefined
        mime = undefined
        size = undefined
        status = undefined
        if err
          return nextor(null)
        headers = r.headers
        mime = headers['content-type']
        size = headers['content-length']
        status = r.statusCode
        msgerro = caso.titulo + ' ' + caso._id
        
        if status == 200 and (mime.indexOf('application/pdf') > -1 or mime.indexOf('application/save') >-1)
          return fs.stat('/home/dev/static/public/bib/' + loc.base, (err, stat) ->
            #nao deu erro, tem local
            if !err
              size = stat.size
              return nextor(null,
                pathname: '/home/dev/static/public/bib/' + loc.base
                filename: loc.base
                size: size)
            options =
              method: 'GET'
              url: b
              headers: 'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36'
              followAllRedirects: true
            #nao tem local, busca
            request options, (err, res, body) ->
              if err
                return nextor("Erro request bibliografia: "+ b,
                  pathname: '/home/dev/static/public/bib/' + loc.base
                  filename: loc.base
                  size: size)
              headers = r.headers
              mime = headers['content-type']
              size = headers['content-length']
              status = r.statusCode
              #console.log 'saving file: /home/dev/static/public/bib/' + loc.base
              #escreve o arquivo na pasta de destino
              arq = '/home/dev/static/public/bib/' + loc.base
              fs.writeFile arq, body, (err) ->
                if err
                  return nextor("Error ao escrever arquivo bib na pasta destino ".b, null)
                return nextor null,
                  pathname: arq
                  filename: loc.base
                  size: size
          )
        else if status != 200
          msg = 'ERRO: Arquivo '+b+' do Caso: '+caso.id+' não encontrado. status '+status 
          console.log bib, msg
          return nextor(msg)
        else if mime != 'application/pdf'
          msg = 'ERRO: Arquivo '+b+ 'do Caso: '+caso.id+' não é PDF. status '+mime
          console.log bib, msg
          return nextor(msg)
        else
          msg = 'ERRO: Arquivo '+b+ 'do Caso: '+caso.id+' não é 200. status '+status+ ' '+mime
          console.log bib, msg, mime.indexOf('application/pdf'), mime.indexOf('application/save')
          return nextor(msg)
        return

  deu = (err, mapped) ->
    # throw err if err
    cb err, mapped.filter((a) ->
      Boolean a
    )

  async.map bibs, mapper, deu

# ---
# generated by coffee-script 1.9.2

# ---
# generated by js2coffee 2.2.0