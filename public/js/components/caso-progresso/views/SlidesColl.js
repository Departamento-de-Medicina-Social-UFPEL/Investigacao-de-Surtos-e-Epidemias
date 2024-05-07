// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['./SlidesFactory'], function(SlideFactory) {
  var SlidesCollView;
  SlidesCollView = (function(_super) {
    __extends(SlidesCollView, _super);

    function SlidesCollView() {
      return SlidesCollView.__super__.constructor.apply(this, arguments);
    }

    SlidesCollView.prototype['tagName'] = 'div';

    SlidesCollView.prototype['class'] = 'listaSlides';

    SlidesCollView.prototype['childView'] = Backbone.View;

    SlidesCollView.prototype['buildChildView'] = function(child, ChildViewClass, childViewOptions) {
      var nucleos;
      nucleos = this.collection.caso.get('profissional').split(',').map(function(n) {
        return n.trim().toLowerCase();
      });
      return SlideFactory(child, nucleos);
    };

    SlidesCollView.prototype['initialize'] = function() {
      return this.listenTo(this, 'childview:respondeu', function(itemView, data) {
        App.main.currentvi;
        return this.showTillNext(itemView, data);
      });
    };

    SlidesCollView.prototype['questaoDaVez'] = 0;

    SlidesCollView.prototype['onRender'] = function() {
      this.children.each(function(view) {
        var imgs;
        imgs = view.$el.find('img');
        imgs.css('width', '100%');
        return imgs.each(function(k, v) {
          var src;
          src = $(v).attr('src');
          return $(v).attr('src', "/static/" + src);
        });
      });
      this.questoes = this.children.filter(function(view) {
        return view.model.get('tipo').match(/questao.*/ig);
      });
      this.questoes.forEach(function(q, i) {
        q.$el.prop({
          id: 'questao_' + i
        });
        return q.$el.attr('data-seqid', i);
      });
      this.questoes[this.questaoDaVez].$el.nextAll('section').hide();
      return this.questoes[this.questaoDaVez].$el.addClass('daVez');
    };

    SlidesCollView.prototype['showTillNext'] = function(view) {
      var el, nextQuest, qView, _i, _len, _ref;
      el = view.$el;
      nextQuest = el.nextAll('section.slide[class*="quest"]')[0];
      _ref = this.questoes;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        qView = _ref[_i];
        qView.$el.removeClass('daVez');
      }
      if (nextQuest) {
        $(nextQuest).prevAll('section').show();
        return $(nextQuest).addClass('daVez').show();
      } else {
        return this.children.each(function(view) {
          return view.$el.show();
        });
      }
    };

    return SlidesCollView;

  })(Marionette.CollectionView);
  return SlidesCollView;
});
