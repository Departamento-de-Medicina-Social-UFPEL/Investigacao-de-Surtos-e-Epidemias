// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['marionette', 'backbone'], function(Marionette, Backbone, Ubs, UbsCollView) {
  var MunCollView;
  MunCollView = (function(_super) {
    __extends(MunCollView, _super);

    function MunCollView() {
      return MunCollView.__super__.constructor.apply(this, arguments);
    }

    MunCollView.prototype.template = function() {
      return '';
    };

    MunCollView.prototype.tagName = 'ul';

    MunCollView.prototype.className = 'lista-municipios';

    MunCollView.prototype['events'] = {
      'change': 'doChange'
    };

    MunCollView.prototype['doChange'] = function(evt) {
      var codibge, current, self, ufSel;
      self = this;
      current = App.main.currentView;
      codibge = this.$el.val();
      if (!(codibge > 0)) {
        return current.selUbs.empty();
      }
      ufSel = current.selUf.$el.find('select').val();
      return App.appRouter.navigate("comp/ubs/new/" + ufSel + "/" + codibge, true);
    };

    MunCollView.prototype['childView'] = Marionette.ItemView.extend({
      'template': function(leanModel) {
        return _.template('<%-nome%>', leanModel);
      },
      'tagName': 'li',
      'initialize': function() {
        return this.$el.attr({
          value: this.model.get('ibge')
        });
      }
    });

    MunCollView.prototype['onRender'] = function() {
      return console.log('MunCollView::render Done');
    };

    return MunCollView;

  })(Marionette.CollectionView);
  return MunCollView;
});
