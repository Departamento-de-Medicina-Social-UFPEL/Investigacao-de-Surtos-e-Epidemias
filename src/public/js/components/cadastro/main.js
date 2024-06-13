// Generated by CoffeeScript 2.7.0
define(['backbone', './views/telaView', './views/semOfertasView'], function(Backbone, TelaView, SemOfertas) {
  return function(component, parentApp, Backbone, Marionette, $, _) {
    var controller, prefixedRoutes;
    controller = {
      "iniciaPagina": function() {
        var dtAtual, mainView, ofertas;
        App.modals.destroyAll();
        dtAtual = new Date();
        ofertas = window.modulo.ofertas.filter(function(o) {
          return dtAtual >= (new Date(o.data_inicio)) && (new Date(o.data_fim_matricula)) >= dtAtual;
        });
        window.modulo.ofertasAbertas = ofertas;
        if (ofertas.length === 0) {
          mainView = new SemOfertas();
          return App.main.show(mainView);
        } else {
          mainView = new TelaView(App.user);
          return App.modals.show(mainView);
        }
      }
    };
    prefixedRoutes = {
      'comp/cadastro': 'iniciaPagina'
    };
    parentApp.moduloId = window.modulo._id;
    // modulo['conteudos'] = [{nucleo: "Enfermagem"}, {nucleo: "Medicina"}]
    parentApp.appRouter.processAppRoutes(controller, prefixedRoutes);
    return parentApp.on('beforeStart', function() {
      if (App.user) {
        return $('#user-name').html(App.user.nome);
      }
    });
  };
});

//menuEntry =
//  'style':'link'
//  'link':'#comp/cadastro'
//  'icone':'folder-account'
//  'texto': 'Cadastro'
//App.menuEntries.unshift menuEntry