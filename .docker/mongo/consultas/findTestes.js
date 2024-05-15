mongoexport -h 200.132.96.70 -u dev -p dIBmzEm4 --authenticationDatabase=admin -d ccurepo -c casos --type=json --fields titulo,subTitulo,id,tipo,profissional,tsPublicacao,paciente,editores,autor,shortname,slides -q '{"_id":{"$in":[ObjectId("638b54bd41e46f2b2b9a5387"),ObjectId("638b648341e46f6f089a5387")]}}' --out testes.json

//lista testes 638ce4c870428362382f7501
