// Generated by CoffeeScript 2.7.0
define([], function() {
  var Modal;
  Modal = Backbone.Modal.extend({
    initialize: function() {},
    //console.log @model, 'model'
    template: _.template($('#monitoramento-covid-monitoramento-confirma-remover-amostra').html()),
    submitEl: '.btn-excluir',
    cancelEl: '.close-modal',
    submit: function() {
      var dados, id, l;
      id = this.model.get('id');
      l = App.monitoramentos.get(this.model.get('id_local'));
      dados = l.get('dados').filter((d) => {
        return d.id !== id;
      });
      l.set('dados', dados);
      //@model.set('dados', dados)
      App.monitoramentos.update(l);
      return App.main.currentView.render();
    },
    onRender: function() {
      var b;
      b = $('body');
      if (!b.is(':visible')) {
        return b.fadeIn();
      }
    },
    //m = $(this.$el.find('a.close-modal')[0])
    //if m
    //  m.attr('href':'#comp/monitoramento-covid/local/'+@model.get('id_local'))
    onDestroy: function() {
      $('body').removeAttr('style').css({
        display: 'block'
      });
      return $('body').css({
        'overflow': 'auto'
      });
    }
  });
  //location.hash = '#comp/monitoramento-covid/local/'+@model.get('id_local')
  //self.local(@model.get('id_local'))
  return Modal;
});