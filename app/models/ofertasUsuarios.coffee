configdb = require('../../config/mongo_db_config.coffee')
Mongoose = require('mongoose')
ConexRepo = Mongoose.createConnection(configdb.modulos)

OfertaSchema = require './schemas/ofertasUsuariosSchema.coffee'

module.exports = ConexRepo.model "ofertas_usuarios", OfertaSchema
