mongoexport -h 200.132.96.70 -u dev -p dIBmzEm4 --authenticationDatabase=admin -d ccurepo -c bibliografias --type=json --fields titulo,chave,serial,caso,casoId,caso_titulo,url,urlOri,filesize,autor,ano,modulo,atividade,etc,soEtc,noAno,acessoEm -q '{"moduloId" : ObjectId("63758ed55ebc0215731f6c36")}' --out bibliografias.json