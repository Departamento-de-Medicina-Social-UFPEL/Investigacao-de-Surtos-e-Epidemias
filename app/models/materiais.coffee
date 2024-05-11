configdb = require('../../config/mongo_db_config.coffee')
Mongoose = require('mongoose')
ConexRepo = Mongoose.createConnection(configdb.modulos)
timestamps = require 'mongoose-timestamp'
{Schema} = Mongoose
{Types} = Schema
{Mixed} = Types


MaterialSchema = new Schema
  nome: String
  tipo: String
  filesize: String
  url: String
  modulo: String
  unidade: Number

MaterialSchema.plugin timestamps

module.exports = ConexRepo.model "materiais", MaterialSchema