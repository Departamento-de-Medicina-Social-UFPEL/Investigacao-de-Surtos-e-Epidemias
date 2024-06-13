// Generated by CoffeeScript 2.7.0
define([], function() {
  var Paciente;
  Paciente = class Paciente extends Backbone.Model {
    ['initialize'](options) {
      var fe, idade, sexo;
      idade = options.idade.match(/\d{1,}/)[0];
      sexo = options.sexo;
      if (options.idade.indexOf('a') === -1) {
        idade = 1;
      }
      fe = (function() {
        switch (sexo) {
          case 'feminino':
            return 'fenoMulher';
          case 'masculino':
            return 'fenoHomem';
        }
      })();
      fe = (function() {
        switch (false) {
          case !(idade <= 13):
            return 'fenoCrianca';
          case !(idade <= 3):
            return 'fenoBebe';
        }
      })();
      return this.set('fenotipo', fe);
    }

  };
  return Paciente;
});