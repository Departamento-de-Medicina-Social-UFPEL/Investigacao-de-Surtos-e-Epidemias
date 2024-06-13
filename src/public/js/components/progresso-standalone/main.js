// Generated by CoffeeScript 2.7.0
define(['./collections/Progresso', './models/Caso', './controller', './routes', 'backbone'], function(Progresso, Caso, controller, routes, Backbone) {
  return function(component, parentApp, Backbone, Marionette, $, _) {
    var ListaAtividades, key, path, prefixedRoutes, val;
    prefixedRoutes = {};
    for (key in routes) {
      val = routes[key];
      path = `comp/${this.moduleName}${key}`;
      prefixedRoutes[path] = val;
    }
    parentApp.appRouter.processAppRoutes(controller, prefixedRoutes);
    ListaAtividades = Backbone.Collection.extend({
      model: Caso
    });
    parentApp.atividades = new ListaAtividades();
    parentApp.casos = new ListaAtividades();
    parentApp.testes = new ListaAtividades();
    parentApp.progresso = new Progresso();
    return parentApp.on('beforeHistoryStart', function() {
      var local, progresso, respostas;
      ({progresso, local} = App);
      if (local) {
        respostas = local.get("respostas-standalone");
        console.log(respostas);
        if (respostas && respostas.length > 0) {
          return progresso.reset(respostas);
        }
      }
    });
  };
});

//   progresso.temNovosBadges yes