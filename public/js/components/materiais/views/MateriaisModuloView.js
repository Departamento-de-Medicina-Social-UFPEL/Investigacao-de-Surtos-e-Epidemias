// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone.marionette'], function(Marionette) {
  var MateriaisView;
  MateriaisView = (function(_super) {
    __extends(MateriaisView, _super);

    function MateriaisView() {
      return MateriaisView.__super__.constructor.apply(this, arguments);
    }

    MateriaisView.prototype.template = '#materiais-main';

    MateriaisView.prototype.className = 'container impressos-container';

    MateriaisView.prototype.onRender = function() {};

    return MateriaisView;

  })(Marionette.ItemView);
  return MateriaisView;
});
