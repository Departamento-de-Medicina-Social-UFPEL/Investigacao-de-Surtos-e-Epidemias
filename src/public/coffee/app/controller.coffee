define [

], ()->
  'mostraComponente': ()->
    

  'listaComponentesDoModelo': ()->
    # console.log arguments
    {modulo} = window
    
    # console.log modulo
    dest = modulo.navigateOnStart or 'comp/sobre'
    # dest = modulo.type is 'singleComponent'
    console.log modulo.navigateOnStart, dest
    Backbone.history.navigate dest, 'trigger': true