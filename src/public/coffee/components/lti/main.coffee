define [
  './controller'
  './routes'
], (controller, routes) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    lti = window.lti
    modulo = window.modulo
    return false unless (lti and lti.modulo_id is modulo._id)
    console.log lti
    parentApp.user = _.extend((if parentApp.user then parentApp.user else {}), {
      cpf: lti.ext_user_username
      moodleId: lti.user_id
      ficha:
        pessoal:
          nome:
            primeiro: lti.lis_person_name_given
            sobrenome: lti.lis_person_name_family
            completo: lti.lis_person_name_full
      isLti: yes
    })

    if lti.custom_settings
      sett = lti.custom_settings = JSON.parse lti.custom_settings
      if sett.style
        $(el).css css for el, css of sett.style

    menuEntryInstance =
      'style':'link'
      'link':'#comp/lti/instance'
      'icone':'cast-connected'
      'texto': "via #{lti.tool_consumer_instance_guid}"

    ava = lti.tool_consumer_info_product_family_code
    avaName = _.capitalize ava
    voltarAva =
      'style':'link'
      'link':'#comp/lti/return'
      'icone':'exit-to-app'
      'texto': "#{lti.context_title} (#{avaName})"

    App.menuEntries.unshift voltarAva
    App.menuEntries.unshift menuEntryInstance

    prefixedRoutes = {}
    for key, val of routes
      path = "comp/#{@moduleName}#{key}"
      prefixedRoutes[path] = val
    parentApp.appRouter.processAppRoutes controller, prefixedRoutes