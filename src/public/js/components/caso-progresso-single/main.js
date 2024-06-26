// Generated by CoffeeScript 2.7.0
define(['./controller', './routes'], function(controller, routes) {
  return function(component, parentApp, Backbone, Marionette, $, _) {
    var appComponent, casoLean, key, path, prefixedRoutes, val;
    prefixedRoutes = {};
    for (key in routes) {
      val = routes[key];
      path = `comp/${this.moduleName}${key}`;
      prefixedRoutes[path] = val;
    }
    console.log(prefixedRoutes, controller);
    parentApp.appRouter.processAppRoutes(controller, prefixedRoutes);
    appComponent = _.findWhere(window.modulo.components, {
      folder: this.moduleName
    });
    // ISSO TEM QUE IR PARA AS CONFIGURACOES DO COMPONENTE
    parentApp.caso = appComponent.resource[0];
    parentApp.on('beforeHistoryStart', function() {
      return parentApp.appRouter.on("route", function(route, params) {
        var caixa, logo_ufpel;
        logo_ufpel = $('.logo-ufpel-cabeca');
        if (!(logo_ufpel.length > 0)) {
          caixa = $('<li/>').addClass('logo-ufpel-cabeca').css({
            'background-image': `url('${window.defaultStaticFileService}/img/marcas/dms_branco.svg')`
          });
          caixa.on('click', function() {
            return window.open('//' + window.location.host);
          });
          return $('.user-menu').append(caixa);
        }
      });
    });
    casoLean = appComponent.resource[0];
    parentApp.casos.add(casoLean);
    return parentApp.caso.titulo = appComponent.title;
  };
});

// parentApp.hasIntro = false
