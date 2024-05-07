configdb = require('/home/dev/config/mongo_db_config.coffee')
Mongoose = require('mongoose')
ConexRepo = Mongoose.createConnection(configdb.modulos)
timestamps = require 'mongoose-timestamp'
{Schema} = Mongoose
{Types} = Schema
{Mixed, ObjectId} = Types



MonitoramentoSchema = new Schema
  id: 
    type: String
    unique: true
  ibge: String
  municipio: String
  local: String
  user: String
  tipo: String
  ts: Number
  uf: String
  dados:[Mixed] 

MonitoramentoSchema.plugin timestamps

module.exports = ConexRepo.model "monitoramentos", MonitoramentoSchema
