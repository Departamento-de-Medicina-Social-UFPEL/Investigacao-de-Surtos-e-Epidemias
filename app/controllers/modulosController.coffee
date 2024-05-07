fs = require 'fs'
locomotive = require 'locomotive'
Controller = locomotive.Controller

ibge = require 'municipios-ibge'
ufMun = require '../lib/uf-mun.coffee'
_ = require 'lodash'

Modulos = require '../models/moduloModel.coffee'
Ofertas = require '../models/ofertas.coffee'

makePPUfromCalc = require '../scripts/ppucomcapa_calc.coffee'
makePPUfromModulo = require '../scripts/ppucomcapa_modulo.coffee'
_ = require 'lodash'
async = require 'async'
PDFImage = require("pdf-image").PDFImage
zipFolder = require('zip-folder')
ZIP = new require('node-zip')()
PPUsRootFolderCreate = '/tmp/ppus'
path = require('path')
PPUsRootFolder = path.resolve(__dirname, '../../public/ppu/modulos')
repo = path.resolve(__dirname,'../templates/')
jasper = require('node-jasper')(optionsReport = {
  path: '../scripts/jasperreports-6.0.0/',
  reports: {
    # // Report Definition
    "capappu": {
      jasper: repo + '/capasppu.jasper', #Path to jasper file,
      jrxml: repo + '/capasppu.jrxml', #Path to jrxml file,
      conn: 'in_memory_json'
    },
  }
})

_loadModule = (cb)->
  self = this
  q = if @moduloId.length is 24 then {'_id': @moduloId}
  else {'shortname': @moduloId}
  console.log @moduloId, '@moduloId', q
  Modulos.findOne(q).lean().exec (err, modulo) ->
    if not modulo
      return self.render 'notfound'
    self.modulo = modulo
    Ofertas.find({modulo: modulo._id}).lean().exec (err, ofertas)->
      self.modulo['ofertas'] = ofertas
      cb.apply self if cb

_loadTempaltes = (cb)->
  self = this
  _loadModule _loadTempaltes unless @modulo
  Modulos.getTemplateFiles @modulo._id, (err, templates) ->
    for k, file of templates
      templates[k] = fs.readFileSync file, 'utf-8'
    self.templates = templates
    cb.apply self if cb

_hydrate = (cb)->
  self = this
  _loadModule.apply(this, [_hydrate]) unless @modulo
  Modulos.externalResources @modulo._id, (err, hidratedComponents) ->
    self.modulo.components = hidratedComponents
    cb.apply self if cb

class ModulosController extends Controller
  getFolder:(modulo, zip = false)->
    # console.log modulo.name, modulo.name.indexOf('Calc'), 'tes get folder'
    if modulo.name.indexOf('Calc') > -1
      short = "calculadora-#{modulo.shortname}"
    else
      short = "modulo-#{modulo.shortname}"
    namespace = short.toUpperCase().replace /[^A-Z]*/img, ''
    ns = "UFPEL_0001_#{namespace}"
    if not zip
      folder = "#{PPUsRootFolder}/#{ns}"
    else
      folder = "#{PPUsRootFolder}/#{ns}.zip"
    folder
  "index": ()->
    # console.log 'redir'
    @res.redirect '/'

  # "create": ()->
  #   # LTI handle
  #   # console.log @req.originalUrl
  #   @res.redirect @req.originalUrl

  "showBasicInfo": ->

  "show": ()->
    self = this
    @moduloId = @params 'id'
    @moduloId = '5474EB2F70BF95195804F780' unless @moduloId
    @estados = _.sortBy ufMun, (est)->
      do est.nome.toLowerCase if est.nome

    _loadModule.apply this, [
      ->
        @req.session.ltis ?= []
        @lti_tc = @req.lti?.body || false;
        tag = {modulo_id: @modulo._id}
        lti = _.find @req.session.ltis, tag
        self = this
        self.req.socket.on @moduloId, () ->
          console.log '-------------', arguments

        unless lti
          novo = @lti_tc
          if novo
            novo.modulo_id = @modulo._id
          @req.session.ltis.push novo
          @lti_tc = novo
        else
          @lti_tc = lti
        _loadTempaltes.apply this, [
          -> _hydrate.apply this, [
            -> @render 'show'
    ] ] ]
  
  "showPpu":()->
    self = @
    id = @params('id')
    Modulos.findOne({_id:id},{_id:1, shortname:1, name:1}).exec (err, modulo)=>
      if err
        return self.res.json 500, {msg:"Erro ao consultar arquivo do ppu"}
      folder = self.getFolder(modulo)
      fs.exists folder, (exists)->
        if err or not exists
          return self.res.json 400, {msg:"Arquivo não encontrado!"}
        ZIP.file folder, folder+'.zip'
        data = ZIP.generate {base64:false,compression:'DEFLATE'}
        if data
          console.log(folder+'.zip')
          # self.res.set('Content-Type', 'application/zip, application/octet-stream, application/x-zip-compressed, multipart/x-zip')
          return self.res.download(folder+'.zip')
        else
          return self.res.status(403).send("Erro ao gerar arquivo")
  "create":()->
    self = @
    id = @params('id')
    Modulos.findOne _id: id
    .exec (err, modulo)->
      try
        throw err if err
        if not modulo
          return self.res.json( 500, {msg:"Módulo informado não encontrado: "})
        console.log modulo.name, 'name modulo', modulo.name.indexOf('Calc')
        if modulo.name.indexOf('Calc') > -1
          makePPUfromModulo = makePPUfromCalc
          console.log 'escolheu calc'
        else
          console.log 'escolheu modulo'
          makePPUfromModulo = makePPUfromModulo
        makePPUfromModulo modulo, (err)->
          console.log("deu erro ao construir ppu") if err
          return self.res.json( 500, {msg:"Erro ao consultar arquivo do ppu: "+err}) if err
          console.log "feito #{modulo.name}"

          # AQUI COMEÇA A GERAR A CAPA
          item = {"titulo": modulo.name, "nucleo": ""}
          dataset = [ {} ]
          nameReport = 'capappu'
          report = 
            report: nameReport
            data: item
            dataset: dataset
          console.log 'item', item
          filename = 'capa'
          deposito = self.getFolder(modulo)
          console.log 'deposito', deposito
          try
            r = jasper.export(report, 'pdf')
          catch err
            return self.res.json( 500, {msg:"Erro ao consultar arquivo do ppu: "+err}) if err 
          console.log 'R', r
          f = path.resolve(deposito, filename + '.pdf')
          console.log 'path', f 
          fs.writeFile f, r, { 'encoding': 'utf-8', 'mode': '0666' }, (err) ->
            # var ok = true;
            console.log 'escreveu arquivos', err
            return self.res.json( 500, {msg:"Erro ao consultar arquivo do ppu: "+err}) if err
            fs.chmod f, '0777', (err) ->
              console.log 'escreveu arquivos 0777', err
              return self.res.json( 500, {msg:"Erro ao consultar arquivo do ppu: "+err}) if err   
              pdfImage = new PDFImage(f)
              console.log 'escreveu arquivos pdfImage', f
              pdfImage.convertPage(0, {omitPageNumOnFileName:true})
              # pdfImage.convertPage(0)
              .then(
                (imagePath)->
                  console.log 'pdf img arquivos', imagePath
                  if !fs.existsSync(imagePath)
                    return self.res.json( 500, {msg:"Erro ao criar arquivo de imagem: "+imagePath})
                  else
                    fs.unlink f, (err) ->
                      urlPasta = self.getFolder(modulo)
                      urlZip = self.getFolder(modulo, true)
                      console.log 'urlPasta ==>', urlPasta
                      console.log 'urlZip ==>', urlZip
                      zipFolder urlPasta, urlZip, (err) ->
                        if err
                          return self.res.json( 500, {msg:"Erro ao criar zip arquivo do ppu: "+err})
                        else
                          return self.res.json 200, {msg: "PPU criado com sucesso!"}
                (e)->
                  return self.res.json( 500, {msg:"Erro ao escrever capa: "+e}) if e
              )
              return
            return
      catch e
        console.log e ,'erro'
        return self.res.json 500, {msg:"Erro ao construir arquivo do ppu: "+e}
c = new ModulosController()
esperaJasper = (req,res,next)->
  if !jasper.hm
    jasper.ready(next)
  else
    next()
c.before 'create', esperaJasper
module.exports = c