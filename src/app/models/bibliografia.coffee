configdb = require('../../config/mongo_db_config.coffee')
Mongoose = require('mongoose')
ConexRepo = Mongoose.createConnection(configdb.modulos)
timestamps = require 'mongoose-timestamp'
{Schema} = Mongoose
{Types} = Schema
{Mixed} = Types

# ConexRepo = Mongoose.createConnection 'mongodb://localhost/modulos'

BiblioSchema = new Schema
  titulo: String
  chave: String
  serial: String
  caso: String
  casoId: String
  caso_titulo: String
  url: String
  urlOri: String
  filesize: String
  autor: String
  ano: String
  modulo: String
  atividade: String
  etc: String
  soEtc: Boolean
  noAno: Boolean
  acessoEm: 
    type: String
    'default': Date.now().toString()

BiblioSchema.plugin timestamps

module.exports = ConexRepo.model "bibliografias", BiblioSchema