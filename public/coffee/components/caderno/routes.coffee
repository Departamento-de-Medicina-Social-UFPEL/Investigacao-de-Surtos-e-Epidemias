define [
], ()->
  # rota raiz do componente comp/nome
  "": "mostraMenuView"
  # rotas internas inicial com - / - !!!
  "/:cnes": "mostraUbs"
  "/:cnes/:acao": "mostraAcao"