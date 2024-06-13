// Generated by CoffeeScript 2.7.0
define(['./home/HomeComp', './interna/AmbienteView', 'backbone'], function(HomeCompositeView, AmbienteView, Backbone) {
  return {
    "iniciaPagina": function(callback) {
      var mainView;
      mainView = new HomeCompositeView();
      App.main.show(mainView);
      if (callback) {
        return callback.apply(this);
      }
    },
    "carregaAmbiente": function(ambiente) {
      var model;
      model = App.quedas.findWhere({
        'folder': ambiente
      });
      return App.main.show(new AmbienteView({model}));
    }
  };
});