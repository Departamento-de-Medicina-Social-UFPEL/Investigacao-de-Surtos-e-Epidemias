// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone'], function(Backbone) {
  var Caderno;
  return Caderno = (function(_super) {
    __extends(Caderno, _super);

    function Caderno() {
      return Caderno.__super__.constructor.apply(this, arguments);
    }

    Caderno.prototype['sync'] = function() {
      return console.log(arguments);
    };

    Caderno.prototype['initialize'] = function() {
      return console.log(arguments);
    };

    return Caderno;

  })(Backbone.Collection);
});
