// Generated by CoffeeScript 2.7.0
define(['marionette'], function(Marionette) {
  var MainLayoutView;
  MainLayoutView = (function() {
    class MainLayoutView extends Marionette.LayoutView {};

    MainLayoutView.prototype['template'] = '#ubs-lista-layout';

    MainLayoutView.prototype['regions'] = {
      'selUf': '#selUf',
      'selMun': '#selMun',
      'selUbs': '#selUbs'
    };

    return MainLayoutView;

  }).call(this);
  return MainLayoutView;
});