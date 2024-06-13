define [
  'marionette',
  'async!//maps.googleapis.com/maps/api/js?language=pt-BR&sensor=false&key=AIzaSyBsUYEmrzqWefMa5lVRbWhajEaT82T-qpw'
], (Marionette) ->
  class InfoModalView extends Marionette.ItemView
    'className': 'modal fade'
    'template': '#ubs-nova-modal-info'
    'ui':
      'map': '#ubs-map-box'
    'events':
      'click .btn-primary': 'susto'
    'susto': (evt)->
      console.log evt
    'onRender': () ->
      self = @
      console.log 'InfoModalView::render Done'
      @$el.on 'hidden.bs.modal', (evt)->
        frag = Backbone.history.fragment;
        frag = frag.substring 0, frag.lastIndexOf '/'
        console.log frag
        App.appRouter.navigate frag
        do $(evt.currentTarget).remove

      Geocoder = new google.maps.Geocoder
      d = @model
      num = d.get 'numero'
      num = if _.isNaN parseInt num then '' else ",#{num}"
      rua = d.get 'logradouro'
      bairro = d.get 'bairro'
      logra = "#{rua}#{num}"
      municipio = d.get 'municipio'
      address = "#{logra}, #{d.get 'municipio'}, #{d.get 'uf'}, Brasil"
      console.log address
      Geocoder.geocode {address}, (res, status)->
        if status is google.maps.GeocoderStatus.OK
          geocode = res[0]
          console.log geocode
          parts = geocode.address_components
          len = parts.length
          u = 17/5
          zoom = Math.ceil(len*u)
          zoom = 17 if zoom > 17
          console.log len, zoom
          mapOptions =
            'zoom': zoom
            'center': geocode.geometry.location
            'disableDoubleClickZoom': false
            'disableDefaultUI': true
            'scaleControl': false
            'zoomControl': true
            'zoomControlOptions': style: 1, position: 8
            'panControl': true
            'panControlOptions': style: 1, position: 8
            # 'mapTypeControl': true

          mapEl = self.ui.map[0]

          map = new google.maps.Map mapEl, mapOptions

          latLong = res[0].geometry.location

          staticMarker =
            'position': latLong
            'icon':
              'path': google.maps.SymbolPath.CIRCLE
              'strokeColor': '#5264AE'
              'strokeOpacity': 0.4
              'fillColor': 'hsla(0,0%,0%,0)'
              'scale': 16
            'map': map
            'draggable': true
            'title': d.get 'nome'

          marker = new google.maps.Marker staticMarker

          coords = latLong.toUrlValue()

          contentString = latLong.toUrlValue()

          infowindow = new google.maps.InfoWindow
            content: contentString

          google.maps.event.addListener marker, "click", ->
            infowindow.open map, marker
            return

          center = do map.getCenter

          console.log map.setCenter latLong

          self.centerMap = ()->
            clearTimeout window._tempLos
            window._tempLos = setTimeout (map, pos)->
              map.setCenter pos
            , 500, map, center

          google.maps.event.addDomListener window, 'resize', self.centerMap

          do self.centerMap

          google.maps.event.addListenerOnce map, 'idle', ()->
            "Mapa Carregado"


          window.map = self.ui.map



  InfoModalView