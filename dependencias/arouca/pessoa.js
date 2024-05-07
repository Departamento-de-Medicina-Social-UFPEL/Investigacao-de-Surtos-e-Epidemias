var PessoaModel,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;
var request = require('request');
var os = require('os');
if(os.hostname() == 'dms-dev'){
 var endPoint = 'http://127.0.0.1/apiarouca/'
 console.log(endPoint, 'endPoint')
}else{
var endPoint = 'http://200.17.160.40/apiarouca/';
  
}
PessoaModel = (function() {
  function PessoaModel() {}

  PessoaModel.prototype['find'] = function(query, callback) {
    var self = this;
    var data = query;
    data['metodo'] = 'recuperarPessoa';
    request.post({
      url:endPoint+'index.php',
      form: data
    }, function(err, httpResponse, body ){
      if(err)
        throw err;
      // console.log('test', err,body);
      return callback.apply(self, [err, JSON.parse(body), httpResponse]);
    });
  };
  PessoaModel.prototype['exists'] = function(query, callback) {
    var self = this;
    var data = query;
    data['metodo'] = 'existePessoa';
    request.post({
      url:endPoint+'index.php',
      form: data
    }, function(err, httpResponse, body ){
      if(err)
        throw err;
      console.log('test', err, httpResponse.statusCode, body);
      return callback.apply(self, [err, JSON.parse(body), httpResponse]);
    });
  };
  PessoaModel.prototype['onOnline'] = function(query, callback) {
    var self = this;
    var data = query;
    data['metodo'] = 'existePessoa';
    request.post({
      url:endPoint+'index.php',
      timeout: 60000,
      form: data
    }, function(err, httpResponse, body ){
      if(err)
        if(err.code == 'ESOCKETTIMEDOUT')
          return callback.apply(self, [404, null, httpResponse]);
        else
          throw err;
      if(httpResponse.statusCode == 500){
        return callback.apply(self, [404, null, httpResponse]);
      }
      return callback.apply(self, [err, JSON.parse(body), httpResponse]);
    })

  };

  PessoaModel.prototype['create'] = function(query, callback) {
    var self = this;
    var data = query;
    data['metodo'] = 'cadastrarPessoa';
  
    request.post({
      url:endPoint+'index.php',
      form: data
    }, function(err, httpResponse, body ){
      if(err)
        throw err;
      // console.log('test create pessoa', err, JSON.parse(body));
      return callback.apply(self, [err, JSON.parse(body), httpResponse]);
    });
  };

  return PessoaModel;

})();
module.exports = new PessoaModel;