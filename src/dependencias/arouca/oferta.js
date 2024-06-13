var OfertaModel, extend;
extend = require('extend');
var request = require('request');
var os = require('os');
if(os.hostname() == 'dms-dev'){
 var endPoint = 'http://127.0.0.1/apiarouca/'
 console.log(endPoint, 'endPoint')
}else{
var endPoint = 'http://200.17.160.40/apiarouca/';
  
}

OfertaModel = (function() {
  function OfertaModel() {}

  OfertaModel.prototype['find'] = function(query, callback) {
    var self = this;
    var data = query;
    data['metodo'] = 'recuperarOferta';
    request.post({
      url: endPoint+'index.php',
      form: data
    }, function(err, httpResponse, body ){
      if(err)
        throw err;
      console.log('test oferta find', err,body);
      return callback.apply(self, [err, JSON.parse(body), httpResponse]);
    });
  };
  OfertaModel.prototype['findByLocal'] = function(query, callback) {
    var self = this;
    var data = query;
    data['metodo'] = 'recuperarLocalOferta';
    request.post({
      url: endPoint+'index.php',
      form: data
    }, function(err, httpResponse, body ){
      if(err)
        throw err;
      console.log('test oferta findByLocal', err,body);
      return callback.apply(self, [err, JSON.parse(body), httpResponse]);
    });
  };

  OfertaModel.prototype['ingressa'] = function(query, callback) {
    var self = this;
    var data = query;
    data['metodo'] = 'cadastrarIngressante';
    request.post({
      url: endPoint+'index.php',
      form: data
    }, function(err, httpResponse, body ){
      if(err)
        throw err;
      console.log('test oferta ingressa', err, data, body);
      return callback.apply(self, [err, JSON.parse(body), httpResponse]);
    });
  };

  OfertaModel.prototype['desliga'] = function(query, callback) {
    var self = this;
    var data = query;
    data['metodo'] = 'cadastrarDesligamento';
    request.post({
      url: endPoint+'index.php',
      form: data
    }, function(err, httpResponse, body ){
      if(err)
        throw err;
      console.log('test oferta desliga', err, data, body);
      return callback.apply(self, [err, JSON.parse(body), httpResponse]);
    });
  };

  OfertaModel.prototype['certificado'] = function(query, callback) {
    var self = this;
    var data = query;
    data['metodo'] = 'recuperarCertificadoConcluinte';
    request.post({
      url: endPoint+'index.php',
      form: data
    }, function(err, httpResponse, body ){
      if(err)
        throw err;
      body = JSON.parse(body);
      if(body)
        if(body.url){
          url = body['url'];
          body['url'] = url.replace('http://', "https://");
        }
      console.log('test oferta certificado', data, err,body);
      return callback.apply(self, [err, body, httpResponse]);
    });
  };
  return OfertaModel;

})();

module.exports = new OfertaModel;