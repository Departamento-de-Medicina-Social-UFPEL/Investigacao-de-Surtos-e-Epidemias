// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone.marionette'], function(Marionette) {
  var TerminalFooter;
  TerminalFooter = (function(_super) {
    __extends(TerminalFooter, _super);

    function TerminalFooter() {
      return TerminalFooter.__super__.constructor.apply(this, arguments);
    }

    TerminalFooter.prototype.template = '#footer-template';

    TerminalFooter.prototype.className = 'container-fluid big-footer';

    return TerminalFooter;

  })(Marionette.ItemView);
  return TerminalFooter;
});
