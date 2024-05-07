define [
  'backbone'
  './views/telaView'
  './views/enqueteIntroView'
  './views/enqueteCadastroView'
  './views/enqueteConclusaoView'
  './views/enqueteEncerramentoOfertaView'
], (Backbone, TelaView, IntroView, EnqueteCadastro, EnqueteConclusao, EnqueteEncerramentoOferta ) ->

  "iniciaPagina": () ->
    console.log 'lista'
    mainView = new TelaView(App.user)
    App.main.show mainView
  "intro":(cpf, enquete)->
    mainView = new IntroView(cpf, enquete)
    App.modals.show mainView
  "cadastro":(cpf)->
    mainView = new EnqueteCadastro(cpf)
    App.modals.show mainView
  "conclusao":(cpf)->
    mainView = new EnqueteConclusao(cpf)
    App.modals.show mainView
  "encerramento":(cpf)->
    mainView = new EnqueteEncerramentoOferta(cpf)
    App.modals.show mainView
