define [
], ()->

  "": "listaUbs"
  "/nova": "novaUbs"
  "/nova/:uf": "selecionaEstado"
  "/nova/:uf/:ibgeCod": "selecionaMunicipio"
  "/nova/:uf/:ibgeCod/:cnes": "selecionaUbs"