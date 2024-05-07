define ['underscore'], (_)->

  class PopulacaoEmFaixas

        constructor: (faixaUf, sexoFaixaUf)->

          @faixaPorUf = faixaUf
          @faixaPorRelSexo = sexoFaixaUf
          @faixas = _(@faixaPorUf.map((v,k,l)-> v[0] unless [1..l.length-2].indexOf(k) == -1 )).compact().__wrapped__

          @ufs =
            "RO": "Rondônia"
            "AC": "Acre"
            "AM": "Amazonas"
            "RR": "Roraima"
            "PA": "Pará"
            "AP": "Amapá"
            "TO": "Tocantins"
            "MA": "Maranhão"
            "PI": "Piauí"
            "CE": "Ceará"
            "RN": "Rio Grande do Norte"
            "PB": "Paraíba"
            "PE": "Pernambuco"
            "AL": "Alagoas"
            "SE": "Sergipe"
            "BA": "Bahia"
            "MG": "Minas Gerais"
            "ES": "Espírito Santo"
            "RJ": "Rio de Janeiro"
            "SP": "São Paulo"
            "PR": "Paraná"
            "SC": "Santa Catarina"
            "RS": "Rio Grande do Sul"
            "MS": "Mato Grosso do Sul"
            "MT": "Mato Grosso"
            "GO": "Goiás"
            "DF": "Distrito Federal"

        getFaixas:-> @faixas

        getUfs:-> @ufs

        getUfBySigla: (sigla)-> @ufs[sigla.toUpperCase()]

        getFaixasPorUf: (uf)->
          ufCol = @faixaPorRelSexo[0].indexOf uf.toUpperCase()
          ufVals = []
          ufVals.push faixa[ufCol] for faixa in @faixaPorUf
          @getMiolo ufVals, (v)->
            try
              v = v.replace /,/gm, '.'
            catch error

            (parseFloat v) / 100

        getFaixasDestSexoPorUf: (uf)->
          ufCol = @faixaPorRelSexo[0].indexOf uf.toUpperCase()
          ufVals = []
          ufVals.push faixa[ufCol] for faixa in @faixaPorRelSexo
          @getMiolo ufVals, (v)->
            try
              v = v.replace /,/gm, '.'
            catch error

        getData: (uf, locPop)->
          popDist = @getFaixasPorUf(uf)
          sexDist = @getFaixasDestSexoPorUf(uf)
          console.log locPop
          faix = []
          for k of @faixas
            total = locPop * popDist[k]
            genero = @propPorGen sexDist[k], total
            perF = genero.F * 100
            perM = 100 - (genero.F * 100)
            faix.push
              nome: @faixas[k]
              total: total
              perTotal: popDist[k] * 100
              totM: perM * total / 100
              perM: perM
              totF: perF * total / 100
              perF: perF

          upperSigla = do uf.toUpperCase

          estado: @ufs[upperSigla]
          sigla: upperSigla
          populacao:
            total: locPop
            feminino: faix.reduce(
              (sum, faixa)-> sum += faixa.totF; sum
            , 0)
            masculino: faix.reduce(
              (sum, faixa)-> sum += faixa.totM
            , 0)
          faixas: faix

        propPorGen: (MalesPerFemale)->
          total = MalesPerFemale + 50
          totalM = (MalesPerFemale / total)
          totalF = (50 / total)
          M: totalM , F: totalF

        getMiolo: (arr)->
          # console.log arguments
          arg = arguments[1]
          ret = arr[1...-1]
          if typeof arg is 'function'
          then ret.map arg
          else ret

        findKey: (obj, value)->
          console.log arguments
          for k, v of obj
            console.log value, v, k
            eh = v is value
            console.log """
            #{v} is #{value} ? #{eh}
            """
            return k if eh

  PopulacaoEmFaixas