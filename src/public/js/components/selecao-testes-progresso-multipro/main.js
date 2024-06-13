// Generated by CoffeeScript 2.7.0

// '../../ProgressoCollection'
define(['./controller', './routes', './models/Caso', 'utils'], function(controller, routes, Caso, utils) {
  return function(component, parentApp, Backbone, Marionette, $, _) {
    var appComponent, i, itemModule, key, len, path, prefixedRoutes, referenceModule, t, testesLean, val;
    prefixedRoutes = {};
    for (key in routes) {
      val = routes[key];
      path = `comp/selecao-testes-progresso${key}`;
      prefixedRoutes[path] = val;
    }
    parentApp.appRouter.processAppRoutes(controller, prefixedRoutes);
    appComponent = _.findWhere(window.modulo.components, {
      folder: this.moduleName
    });
    // ISSO TEM QUE IR PARA AS CONFIGURACOES DO COMPONENTE
    itemModule = '#comp/teste-progresso';
    component.routeFactory = function(id) {
      return `${itemModule}/${id}`;
    };
    referenceModule = '#comp/caso-progresso';
    component.refRouteFactory = function(id) {
      return `${referenceModule}/${id}`;
    };
    if (!window.App['selecao-testes-progresso']) {
      window.App['selecao-testes-progresso'] = {};
      window.App['selecao-testes-progresso'].refRouteFactory = component.refRouteFactory;
    }
    appComponent.resource.casos = appComponent.resource.casos.map(function(c) {
      c.tipo = 'teste';
      c.posTeste = !(/inicial/img.test(c.titulo));
      // console.log c.posTeste
      return c;
    });
    $('.dropdown-componentes').find('.dropdown-menu a[href="#comp/selecao-testes-progresso-multipro"]').attr('href', '#comp/selecao-testes-progresso');
    parentApp.selecaoTestes = appComponent.resource;
    testesLean = appComponent.resource.casos;
    for (i = 0, len = testesLean.length; i < len; i++) {
      t = testesLean[i];
      parentApp.atividades.add(t);
      parentApp.testes.add(t);
    }
    return parentApp.selecaoTestes.titulo = appComponent.title;
  };
});