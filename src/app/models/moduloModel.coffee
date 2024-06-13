configdb = require('../../config/mongo_db_config.coffee')
Mongoose = require('mongoose')

ConexRepo = Mongoose.createConnection(configdb.modulos)
ModuloSchema = require "./schemas/moduloSchema.coffee"
module.exports = ConexRepo.model 'modulos', ModuloSchema