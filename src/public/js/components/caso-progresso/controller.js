// Generated by CoffeeScript 2.7.0
define(['./models/Caso', './views/MainCasoLayout', './views/NotFound'], function(CasoModel, MainCasoView, NotFoundView) {
  return {
    "mostraCaso": function(id) {
      var ViewType, caso, mainView, opt;
      if (!App.user) {
        return;
      }
      App.main.once('show', function() {
        return setTimeout((function() {
          return window.$.material.init();
        }), 10);
      });
      caso = App.casos.findWhere({
        _id: id.toLowerCase()
      });
      ViewType = NotFoundView;
      if (caso) {
        ViewType = MainCasoView;
        opt = {
          model: caso
        };
      }
      mainView = new ViewType(opt);
      return App.main.show(mainView);
    }
  };
});
