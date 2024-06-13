locomotive = require 'locomotive'
Controller = locomotive.Controller
_ = require 'lodash'
async = require 'async'
fs = require('fs')
PDFImage = require("pdf-image").PDFImage
zipFolder = require('zip-folder')
ZIP = new require('node-zip')()
Casos = require '../models/caso.coffee'
path = require('path')
repo = path.resolve(__dirname,'../templates/')


class CasosController extends Controller
  # lista acoes
  index: ()->
    self = this
    Casos.find({titulo:{$ne:""}},{_id:1, shortname:1, titulo:1, id:1, editores:1, autor:1, tsPublicacao:1, profissional:1}).lean().exec (err, casos)=>
      console.log casos, err, '======= casos ====='
      if err
        return self.res.json 500, {msg:'Erro ao consultar caso clinico'}
      iterador = (caso, callback)->
        folder = self.getFolder(caso)
        fs.exists folder, (exists) => 
          caso['ppu_criado'] = exists
          callback null, caso
      callbackf = (err, result)->
        if err
          return self.res.json 500, {msg:"Erro ao buscar PPUs"}
        return self.res.json 200, result
      async.map(casos, iterador, callbackf)
  
  show:()->
    self = @
    id = @params('id')
    Casos.findOne({_id:id},{_id:1, shortname:1, titulo:1}).exec (err, caso)=>
      if err
        return self.res.json 500, {msg:"Erro ao consultar arquivo do ppu"}
      folder = self.getFolder(caso)
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


c = new CasosController()

module.exports = c