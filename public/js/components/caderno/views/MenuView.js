// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['./MenuItemAcaoView', 'marionette'], function(MenuItemAcaoView, Marionette) {
  var MenuView;
  return MenuView = (function(_super) {
    __extends(MenuView, _super);

    function MenuView() {
      return MenuView.__super__.constructor.apply(this, arguments);
    }

    MenuView.prototype['template'] = '#caderno-menuAcoes';

    MenuView.prototype['className'] = 'container';

    MenuView.prototype['childView'] = MenuItemAcaoView;

    MenuView.prototype['childViewContainer'] = '#lista-acoes';

    MenuView.prototype['initialize'] = function() {
      return console.log(arguments);
    };

    return MenuView;

  })(Marionette.CompositeView);
});
