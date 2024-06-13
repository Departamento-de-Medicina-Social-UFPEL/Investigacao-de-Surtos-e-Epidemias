// Generated by CoffeeScript 2.7.0
define(['./controller', './routes'], function(controller, routes, TelaView) {
  return function(component, parentApp, Backbone, Marionette, $, _) {
    var key, path, prefixedRoutes, val;
    prefixedRoutes = {};
    for (key in routes) {
      val = routes[key];
      path = `comp/${this.moduleName}${key}`;
      prefixedRoutes[path] = val;
    }
    parentApp.appRouter.processAppRoutes(controller, prefixedRoutes);
    return parentApp.on('beforeStart', function() {
      var menuEntry;
      menuEntry = {
        'style': 'link',
        'link': '#comp/logout',
        'icone': 'logout',
        'texto': "Sair"
      };
      return App.menuEntries.push(menuEntry);
    });
  };
});