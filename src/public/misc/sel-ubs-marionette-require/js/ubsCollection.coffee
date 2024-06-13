define ['js/dummy'], (dummy)->

  class UbsCollection extends Backbone.Collection
    url: -> "//dms.ufpel.edu.br/casca/ubs/busca/codibge/#{@ibge}"
    parse: (ubss)->
      @reset [do dummy].concat ubss.map (i)-> value: i.cnes, text: i.nome


