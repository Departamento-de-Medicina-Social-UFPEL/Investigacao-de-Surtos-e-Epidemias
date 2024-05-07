define [
  'backbone'
  './views/telaView'
  './views/semOfertasView'
], (Backbone, TelaView, SemOfertas) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    controller =
      "iniciaPagina": () ->
        App.modals.destroyAll()
        dtAtual = new Date()
        ofertas = window.modulo.ofertas.filter (o)->
          return (dtAtual >= (new Date(o.data_inicio)) and (new Date(o.data_fim_matricula)) >= dtAtual)
        window.modulo.ofertasAbertas = ofertas
        if ofertas.length is 0
          mainView = new SemOfertas()
          App.main.show mainView
        else
          mainView = new TelaView(App.user)
          App.modals.show mainView

    prefixedRoutes =
      'comp/cadastro': 'iniciaPagina'

    parentApp.moduloId= window.modulo._id
    # modulo['conteudos'] = [{nucleo: "Enfermagem"}, {nucleo: "Medicina"}]
    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    parentApp.on 'beforeStart', () ->
      if App.user
        $('#user-name').html(App.user.nome);
      #menuEntry =
      #  'style':'link'
      #  'link':'#comp/cadastro'
      #  'icone':'folder-account'
      #  'texto': 'Cadastro'
      #App.menuEntries.unshift menuEntry





