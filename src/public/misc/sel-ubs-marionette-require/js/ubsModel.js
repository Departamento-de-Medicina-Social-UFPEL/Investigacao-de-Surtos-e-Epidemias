// Generated by CoffeeScript 1.9.0
(function() {
  var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __hasProp = {}.hasOwnProperty;

  define([], function() {
    var UbsModel;
    return UbsModel = (function(_super) {
      __extends(UbsModel, _super);

      function UbsModel() {
        return UbsModel.__super__.constructor.apply(this, arguments);
      }

      UbsModel.prototype.urlRoot = function() {
        return '//dms.ufpel.edu.br/casca/ubs';
      };

      return UbsModel;

    })(Backbone.Model);
  });

}).call(this);
