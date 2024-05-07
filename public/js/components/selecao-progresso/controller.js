// Generated by CoffeeScript 1.8.0
define(['./views/MainSelecaoView', './models/Caso', 'backbone'], function(MainSelecaoView, Caso, Backbone) {
  return {
    "mostraSelecaoCasos": function(callback) {
      var coll, mainView;
      if (!App.user) {
        return;
      }
      coll = Backbone.Collection.extend({
        model: Caso
      });
      mainView = new MainSelecaoView({
        collection: new coll(App.selecao.casos)
      });
      App.main.show(mainView);
      if (callback) {
        return callback.apply(this);
      }
    }
  };
});
