configdb = require('../../config/mongo_db_config.coffee')
Mongoose = require('mongoose')
ConexRepo = Mongoose.createConnection(configdb.arouca, {useNewUrlParser: true})


OfertaSchema = require './schemas/ofertaSchema.coffee'

module.exports = ConexRepo.model "ofertas", OfertaSchema
