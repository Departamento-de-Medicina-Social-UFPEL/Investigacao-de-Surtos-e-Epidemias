define ['backbone'], (Backbone)->
  class Criterio extends Backbone.Model
    'initialize': (regra) ->
      @verifica = new Function [
        'prop'
        'valor'
      ], "return prop #{regra.crit} valor"
      @crit = regra.crit
      @propriedade = regra.prop
      @valor = parseFloat regra.val
      if isNaN @valor
        @valor = regra.val

    'test': (referencia)->
      p = @propriedade
      rp = referencia[p]
      v = @valor
      t = @verifica rp, v
      #console.log p, rp, @crit, v, t, 'merece?', referencia, referencia[p]
      t

  class CriteriosBadge extends Backbone.Collection
    model: Criterio

  CriteriosBadge