define [
  './controller'
  './routes'
  'utils'
  'backbone'
], (controller, routes, utils, Backbone) ->

  return (component, parentApp, Backbone, Marionette, $, _)->
    prefixedRoutes = {}
    for key, val of routes
      path = "comp/#{@moduleName}#{key}"

      prefixedRoutes[path] = val

    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    parentApp.on 'beforeStart', ()->
      if parentApp.local
        usr = parentApp.local.get 'user'
        if usr
          if usr.cpf
            unless utils.valCPF usr.cpf
              alert 'O CPF informado no seu cadastro parece estar incorreto.\nVocê precisará preencher o formulário de cadastro novamente.\nPreencha com os campos com atenção e volte a responder as questões.\nBons estudos!'
              parentApp.local.set 'user'
              parentApp.local.set "respostas-#{usr.cpf}"
              return window.location.href = '#comp/cadastro'
          parentApp.user = usr
      if parentApp.user
        respKey = "respostas-#{App.user.cpf}"
        respostas = parentApp.local.get respKey
        # console.log "terminal-main:: parentApp.on 'beforeStart', ()->", usr, respostas
        $('.dropdown-componentes').find('ul.dropdown-menu li').show()
        parentApp.progresso.setUser parentApp.user
        parentApp.progresso.reset respostas
      else
        $('.dropdown-componentes').find('ul.dropdown-menu li').each (idx, el) ->
          $el = $ el
          if $el.find('a').attr('href').includes 'progresso'
            do $el.hide

