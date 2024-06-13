// Generated by CoffeeScript 2.7.0
define(['marionette', 'backbone'], function(Marionette, Backbone, Ubs, UbsCollView) {
  var MunCollView;
  MunCollView = (function() {
    class MunCollView extends Marionette.CollectionView {
      template() {
        return '';
      }

      ['doChange'](evt) {
        var codibge, current, self, ufSel;
        self = this;
        current = App.main.currentView;
        codibge = this.$el.val();
        if (!(codibge > 0)) {
          return current.selUbs.empty();
        }
        ufSel = current.selUf.$el.find('select').val();
        return App.appRouter.navigate(`comp/ubs/new/${ufSel}/${codibge}`, true);
      }

      ['onRender']() {
        return console.log('MunCollView::render Done');
      }

    };

    MunCollView.prototype.tagName = 'ul';

    MunCollView.prototype.className = 'lista-municipios';

    MunCollView.prototype['events'] = {
      'change': 'doChange'
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

    return MunCollView;

  }).call(this);
  return MunCollView;
});