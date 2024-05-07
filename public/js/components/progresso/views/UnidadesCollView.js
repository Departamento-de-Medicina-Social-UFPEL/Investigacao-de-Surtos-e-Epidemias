// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['./UnidadeItemView'], function(UnidadeItemView) {
  var ConteudoCollView;
  ConteudoCollView = (function(_super) {
    __extends(ConteudoCollView, _super);

    function ConteudoCollView() {
      return ConteudoCollView.__super__.constructor.apply(this, arguments);
    }

    ConteudoCollView.prototype.tagName = 'div';

    ConteudoCollView.prototype.className = 'timeline-main';

    ConteudoCollView.prototype.initialize = function() {};

    ConteudoCollView.prototype.childView = UnidadeItemView;

    ConteudoCollView.prototype.childViewContainer = '.timeline';

    ConteudoCollView.prototype.template = '#progresso-unidades';

    ConteudoCollView.prototype.onRender = function() {};

    return ConteudoCollView;

  })(Marionette.CompositeView);
  return ConteudoCollView;
});
