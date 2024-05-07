var configdb = require('/home/dev/config/mongo_db_config.js');
var mongoose = require('mongoose');
// { useMongoClient: true }
// var conn = mongoose.createConnection(configdb.ccurepo);
conn = mongoose.connect(configdb.ccurepo);


    console.log(configdb.ccurepo, 'db')

var Schema = mongoose.Schema,
    ObjectId = Schema.Types.ObjectId,
    Mixed = Schema.Types.Mixed;
// conn.then(function(db) {
    var Casos = conn.model('casos', mongoose.Schema({
            titulo: String,
            subTitulo: String,
            id: Number,
            profissional: String,
            tsPublicacao: Number,
            paciente: Mixed,
            autor: Mixed,
            editores: Mixed,
            slides: [Mixed],
            __v: Number
        }));
    Casos.findOne().exec(function(err, doc){ console.log('doc', doc, err); });
    // console.log(Casos);
