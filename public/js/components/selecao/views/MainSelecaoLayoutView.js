// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['marionette'], function(Marionette) {
  var MainSelecaoLayout;
  return MainSelecaoLayout = (function(_super) {
    __extends(MainSelecaoLayout, _super);

    function MainSelecaoLayout() {
      return MainSelecaoLayout.__super__.constructor.apply(this, arguments);
    }

    MainSelecaoLayout.prototype.template = '#selecao-main';

    MainSelecaoLayout.prototype.className = 'container selecao-main';

    MainSelecaoLayout.prototype.onRender = function() {
      return console.log("MainSelecaoLayout::onRender");
    };

    return MainSelecaoLayout;

  })(Marionette.LayoutView);
});
