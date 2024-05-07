configdb = require('/home/dev/config/mongo_db_config.coffee')
Mongoose = require('mongoose')
ConexRepo = Mongoose.createConnection(configdb.modulos, {useNewUrlParser: true})
#ConexRepo = Mongoose.connect(configdb.modulos, {useNewUrlParser: true})

timestamps = require 'mongoose-timestamp'
{Schema} = Mongoose
{Types} = Schema
{Mixed} = Types


UserSchema = new Schema
  cpf: 
    type: String
    unique: true
  nome: String
  sexo: String
  profissional: String
  nucleo_profissional: String
  dataNasc_dia: String
  dataNasc_mes: String
  dataNasc_ano: String
  nomeMae: String
  email: String
  uf: String
  municipio: String
  ibge: String
  touch: Number
  flag: String
  especifico: [Mixed]
  monitoramentos: Mixed
  ofertas:[]
  mala_direta: Boolean
  certifica:
    type: Boolean
    default: false
  fl_cadastro_completo:Boolean
  enquetes: Mixed
  alt_anos_vigilancia_sus: String
  alt_atua_ambulatorio_especializado: String
  alt_atua_atencao_basica: String
  alt_atua_filantropico: String
  alt_atua_gestao_saude: String
  alt_atua_hospital_emergencia: String
  alt_atua_no_sus: String
  alt_atua_pesquisa: String
  alt_atua_pronto_atendimento: String
  alt_atua_saude_privada: String
  alt_atuou_vigilancia_sus: String
  alt_genero: String
  alt_nome_profissao: String
  alt_profissao: String
  alt_qual_profissao: String
  alt_raca_cor: String
  alt_tempo_profissao: String

UserSchema.plugin timestamps

module.exports = ConexRepo.model "usuarios", UserSchema