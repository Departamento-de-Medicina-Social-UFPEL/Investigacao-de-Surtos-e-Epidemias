// Generated by CoffeeScript 1.8.0
define(['./views/MainSelecaoView', 'backbone'], function(MainSelecaoView, Backbone) {
  return {
    "mostraSelecaoCasos": function(callback) {
      var mainView;
      console.log("mostraSelecaoCasos");
      if (!App.user) {
        return;
      }
      mainView = new MainSelecaoView({
        collection: App.testes
      });
      App.main.show(mainView);
      if (callback) {
        return callback.apply(this);
      }
    }
  };
});
