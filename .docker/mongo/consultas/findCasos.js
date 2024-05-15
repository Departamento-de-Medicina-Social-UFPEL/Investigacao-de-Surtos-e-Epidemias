mongoexport -h 200.132.96.70 -u dev -p dIBmzEm4 --authenticationDatabase=admin -d ccurepo -c casos --type=json --fields titulo,subTitulo,id,tipo,profissional,tsPublicacao,paciente,editores,autor,shortname,slides -q '{"_id":{"$in":[ObjectId("62f39ab641e46ff40a7cc73d"), ObjectId("62f968a141e46f53119d100b"), ObjectId("62f97d9041e46f60119d100b"), ObjectId("62fae14e41e46f423d2cfd67"), ObjectId("62faf42e41e46fb4652cfd67"), ObjectId("62fb004a41e46f607c2cfd67"), ObjectId("630cb5ca41e46fa01e0115f8"), ObjectId("630d355f41e46fab300115f8"), ObjectId("6339dc1741e46fdf39ff213c"), ObjectId("633ad71f41e46f8f531c95d1"), ObjectId("633ae23241e46fbd641c95d1"), ObjectId("635bd84341e46f0207fcaaf8"), ObjectId("63658eb741e46f062ffeb744"), ObjectId("6369412741e46f1a322f6a06"), ObjectId("6369617241e46f14322f6a06")]}}' --out casos.csv

lista testes
638ce4c870428362382f7501

lista casos
638ce58070428362382f7506

