define [
  '../../models/Slide',
  './Anamnese',
  './Historico',
  './Exame',
  './QueSimples',
  './QueMultipla',
  './Biblio',
  './SlidePadrao'
], (SlideModel, Anamnese, Historico, Exame, QueSimples, QueMultipla, Biblio, Padrao) ->
  (data) ->
    tipo = data.get 'tipo'
    RealSlideView = switch tipo
      when 'anamnese' then Anamnese
      when 'histClin' then Historico
      when 'exameFisico' then Exame
      when 'questaoSimples' then QueSimples
      when 'questaoMulti' then QueMultipla
      when 'bibliografia' then Biblio
      else Padrao
    new RealSlideView
      model: data
      tagName: 'section'
      className: "slide slide-#{tipo}"