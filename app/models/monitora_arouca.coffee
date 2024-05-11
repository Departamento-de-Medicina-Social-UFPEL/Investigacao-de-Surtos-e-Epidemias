configdb = require('../../config/mongo_db_config.coffee')
Mongoose = require('mongoose')
ConexRepo = Mongoose.createConnection(configdb.modulos)
timestamps = require 'mongoose-timestamp'
{Schema} = Mongoose
{Types} = Schema
{Mixed} = Types


MonitoraServicoSchema = new Schema
  online: Boolean
  name: String


MonitoraServicoSchema.plugin timestamps

module.exports = ConexRepo.model "monitora_servicos", MonitoraServicoSchema