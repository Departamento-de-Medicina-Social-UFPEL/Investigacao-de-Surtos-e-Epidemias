// Generated by CoffeeScript 2.7.0
define(['./views/MainLayoutView', 'backbone'], function(MainLayoutView, Backbone) {
  return {
    "iniciaPagina": function(callback) {
      var mainView;
      mainView = new MainLayoutView();
      App.main.show(mainView);
      console.log("App.main.show mainView", mainView);
      if (callback) {
        return callback.apply(this);
      }
    },
    "outra": function() {
      return console.log('BAEHUGFOUAE G8yaegfo');
    }
  };
});