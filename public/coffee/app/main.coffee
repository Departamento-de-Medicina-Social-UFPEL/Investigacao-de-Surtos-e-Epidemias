define 'casca', [
  'js/app/views/MenuView'
  'js/app/views/ProgressoLateralView'
  'js/app/regions/FadeTransitionRegion'
  'marionette.modals'
], (MenuView, ProgressoLateralView, FadeTransitionRegion)->

  class Casca extends Marionette.Application

    MenuView: MenuView

    menuEntries: []

    loadUserMenu: () ->
      self = this
      $('#botaoInicial').show()
      self.menuEntries.push
        'style':'link'
        'link':'https://dms.ufpel.edu.br/p2k/contato'
        'icone':'envelope'
        'texto': "Preciso de ajuda"
      self.userMenu.show new MenuView
        model: new Backbone.Model self.user
        collection: new Backbone.Collection self.menuEntries

      dtAtual = new Date()
      ofertasAbertas = new Backbone.Collection window.modulo.ofertas.filter (o)->
        return (dtAtual >= (new Date(o.data_inicio)) and (new Date(o.data_fim_matricula)) >= dtAtual)
        
      
      self.progressoLateral.show new ProgressoLateralView {collection: ofertasAbertas}
      console.log 'fim load menu'

    start: (options)->
      self = @
      self.trigger 'beforeStart'

      @addRegions
        intro: '#introLayer'
        main:
          selector: '#mainStage'
          regionClass: FadeTransitionRegion
        footer: 'footer'
        modals:
          selector: '.modals-container'
          regionClass: Marionette.Modals
        userMenu:
          selector: ".user-menu"
        progressoLateral:
          selector: ".user-menu-progresso"

      if window.modulo.skipIntro
        @hasIntro = false
        
      if window.modulo.style
        classes = ''
        for selector, rule of window.modulo.style
          s = if (selector.indexOf('.') < 0) then s = ".#{selector}" else selector
          classes += "#{s}{ #{rule.join ';'} }"
        $('head').append("<style>#{classes}</style>")

      @main.firstShow = yes
      
      @main.onShow = ->
        return unless self.main.firstShow
        # console.log "@main.on 'show', ->", self.user, self.menuEntries, self.local.get 'user menu'
        if self.user
          # console.log self.menuEntries
          self.loadUserMenu()
          
          # Forçar o usuario a relogar no módulo de investigações por causa
          # do problema em salvar a etapa 2 do formulário.
          if self.moduloId == '63758ed55ebc0215731f6c36' 
            if self.user.alt_raca_cor not in ["Branco", "Preto", "Pardo", "Amarelo", "Indígena"]
            # or self.user.alt_genero not in ["F", "M", "N", "O", "R"]
            # or self.user.alt_profissao not in ["Profissional", "Estudante"]
            # or self.user.alt_atua_ambulatorio_especializado not in ["S", "N"]
            # or self.user.alt_atua_atencao_basica not in ["S", "N"]
            # or self.user.alt_atua_filantropico not in ["S", "N"]
            # or self.user.alt_atua_gestao_saude not in ["S", "N"]
            # or self.user.alt_atua_hospital_emergencia not in ["S", "N"]
            # or self.user.alt_atua_no_sus not in ["S", "N"]
            # or self.user.alt_atua_pesquisa not in ["S", "N"]
            # or self.user.alt_atua_pronto_atendimento not in ["S", "N"]
            # or self.user.alt_atua_saude_privada not in ["S", "N"]
            # or self.user.alt_atuou_vigilancia_sus not in ["A", "S", "N"]
              Backbone.history.navigate 'comp/logout', 'trigger': true

        # if !window.modulo.showComponentMenu
        #   $('button.navbar-toggle').hide()

        do $('body').fadeIn
        $('.navbar-fixed-top .dropdown li a').on 'click', ->
          $ this
          .parents('.navbar-collapse')
          .collapse 'hide'
        self.main.firstShow = off

      if @hasFooter
        @footer.show @footerView

      # @hasIntro = off
      if @hasIntro
        do $('header').hide
        do $('footer').hide
        do $('body').fadeIn
        @intro.show @introView
        andThen = ()->
          App.hasIntro = no
          return null if self.stopOnLoading
          do $('header').fadeIn
          do $('footer').fadeIn
          do $('body').fadeIn
          do self.intro.empty
          self.trigger 'beforeHistoryStart'
          do Backbone.history.start unless Backbone.History.started
        setTimeout andThen, if modulo.intro_img_3 then 10000 else 6000
      else
        do $('body').fadeIn
        self.trigger 'beforeHistoryStart'
        do Backbone.history.start unless Backbone.History.started

  Casca
