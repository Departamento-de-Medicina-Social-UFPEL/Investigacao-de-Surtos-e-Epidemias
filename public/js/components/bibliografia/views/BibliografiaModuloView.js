// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone.marionette'], function(Marionette) {
  var BibliografiaView;
  BibliografiaView = (function(_super) {
    __extends(BibliografiaView, _super);

    function BibliografiaView() {
      return BibliografiaView.__super__.constructor.apply(this, arguments);
    }

    BibliografiaView.prototype.template = '#bibliografia-main';

    BibliografiaView.prototype.className = 'item biblioGeral container';

    BibliografiaView.prototype.onRender = function() {};

    return BibliografiaView;

  })(Marionette.ItemView);
  return BibliografiaView;
});
