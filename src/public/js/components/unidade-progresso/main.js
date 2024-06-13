// Generated by CoffeeScript 2.7.0

// '../../ProgressoCollection'
define(['./controller', './routes', './models/Caso', 'utils'], function(controller, routes, Caso, utils) {
  return function(component, parentApp, Backbone, Marionette, $, _) {
    var appC, appComponents, i, key, len, path, prefixedRoutes, results, val;
    prefixedRoutes = {};
    for (key in routes) {
      val = routes[key];
      path = `comp/${this.moduleName}${key}`;
      prefixedRoutes[path] = val;
    }
    // console.log prefixedRoutes, @moduleName, 'modulo unidade progresso', val, key
    parentApp.appRouter.processAppRoutes(controller, prefixedRoutes);
    appComponents = _.where(window.modulo.components, {
      folder: this.moduleName
    });
    results = [];
    for (i = 0, len = appComponents.length; i < len; i++) {
      appC = appComponents[i];
      if (!appC.resource) {
        break;
      }
      results.push(appC.resource.casos = appC.resource.casos.map(function(c) {
        if (appC.unidade) {
          c.unidade = appC.unidade;
        }
        c.tipo = c.tipo ? c.tipo : 'caso';
        return c;
      }));
    }
    return results;
  };
});

// casosLean = appC.resource.casos
// console.log appC.unidade, 'unidade progresso', casosLean

// for c in casosLean
//   parentApp.atividades.add c
//   parentApp.casos.add c

// parentApp.selecao.titulo = appComponent.title