ip = 'localhost'
ip = 'mamongo'
db = "mongodb://mamongo:mamongo@"+ip+":27017";
MoodleDBconfig = 
  server: ip
  modulos: db + '/modulos?authSource=admin'
  ccurepo: db + '/ccurepo?authSource=admin'
  admin: db + '/admin?authSource=admin'
  arouca: db + '/arouca?authSource=admin'
  cciCasos2: db + '/cciCasos2?authSource=admin'
  certificacao: db + '/certificacao?authSource=admin'

module.exports = MoodleDBconfig