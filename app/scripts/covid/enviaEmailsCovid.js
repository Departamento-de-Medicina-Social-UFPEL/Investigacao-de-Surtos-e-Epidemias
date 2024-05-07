var fs = require('fs');
const {Base64} = require('js-base64');
var Async = require('async');
(path = require("path")),
  (mime = require("mime")),
  (repo = path.resolve(
    __dirname 
  )),
  (repoLib = path.resolve(__dirname + "/../")),
  (AWS = require("aws-sdk")),
  (jasper = require("node-jasper")(
    (optionsReport = {
      path: repoLib + "/jasperreports-6.0.0/",
      reports: {
        // Report Definition
        memorando: {
          jasper: repo + "/memorando-covid.jasper", //Path to jasper file,
          jrxml: repo + "/memorando-covid.jrxml", //, //Path to jrxml file,
          conn: "in_memory_json",
        },
      },
    })
  ));

var self = this;


var next = function(){
  fs.readFile('./email-covid.csv', 'utf-8', function(err, data) {
    if (err) throw err
    else {
      var linhas = data.split('\n');
      var self = this;
      var cpfs = [];
      var cpfs_problema = [];
      console.log('alunos csv',linhas.length);
      linhas.reverse().pop();
      console.log('alunos csv',linhas.length);
      
      Async.reduce(linhas, 0, function(memo, l, callback){
        if (typeof memo == "number") {
          memo = new Array();
        }
        var colunas = l.split(",");
        console.log("colunas", colunas);
        var dataset = [{}];
        var nameReport = "memorando";
        //ID,Nome,Data do TCLE,IgG,IgA,IgM,e-mail,
        //59,Vanderson oliveira da silva,16/10/2020,REAGENTE,NÃO REAGENTE,REAGENTE,vanderson.th@gmail.com,matched (3)
        var report = {
          report: nameReport,
          data: {
            nome: colunas[1],
            dt_exame: colunas[2],
            igg: colunas[3],
            iga: colunas[4],
            igm: colunas[5],
            data: colunas[2],
          },
          dataset: dataset,
        };
        console.log("item", report.data);
        var r = jasper.pdf(report, "pdf");
        enviaEmail(colunas[6], r, function (err) {
          console.log("email enviado");
          callback(err);
        });
      },function(err,result){
        if (err){
          console.log('erro no async matricula');
          throw err;
        }else {
          console.log('não encontrados',result);
        }
      });
    }
  });
}

var enviaEmail = function (destinatario,data, callback) {
  console.log("email", destinatario);
  var remetente = "suporte.moodle.esf@gmail.com";
  AWS.config.loadFromPath("/home/dev/configEmail.json");
  var mensagem = "Olá, segue em anexo o memorando o resultado do seu teste.";
  var nome_file = 'teste.pdf';
  var anexo = "From: <suporte.moodle.esf@gmail.com> \r\nTo: vanderson.th@gmail.com \r\nSubject: Customer service contact info\r\n";
  //anexo += "Content-Type: multipart/mixed;\r\n\r\n";
  anexo +=
    'Content-Type: multipart/mixed; boundary="a3f166a86b56ff6c37755292d690675717ea3cd9de81228ec2b76ed4a15d6d1a" \r\n\r\n';
  
  anexo +='--a3f166a86b56ff6c37755292d690675717ea3cd9de81228ec2b76ed4a15d6d1a\r\n';
    anexo +='Content-Type: multipart/alternative;boundary="sub_a3f166a86b56ff6c37755292d690675717ea3cd9de81228ec2b76ed4a15d6d1a"\r\n\r\n';
    
    anexo +="--sub_a3f166a86b56ff6c37755292d690675717ea3cd9de81228ec2b76ed4a15d6d1a\r\n";
    anexo +="Content-Type: text/html; charset=iso-8859-1\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n";
    anexo +="<html><head></head><body><h1>Hello!</h1><p>Please see the attached file for a list of customers to contact.</p></body></html>\r\n\r\n";
    
    anexo +="--sub_a3f166a86b56ff6c37755292d690675717ea3cd9de81228ec2b76ed4a15d6d1a--\r\n\r\n";
      
    anexo +="--a3f166a86b56ff6c37755292d690675717ea3cd9de81228ec2b76ed4a15d6d1a\r\n";
    anexo +='Content-Type: application/pdf;name="teste.pdf" \r\nContent-Description: teste.pdf \r\nContent-Disposition: attachment;filename="teste.pdf"\r\nContent-Transfer-Encoding: base64\r\n\r\n';
    anexo += Base64.encode(data); 
  anexo += "\r\n\r\n--a3f166a86b56ff6c37755292d690675717ea3cd9de81228ec2b76ed4a15d6d1a--\r\n\r\n";

  
  console.log(anexo);

  var ses = new AWS.SES();
  ses.sendRawEmail(
    {

      Destinations: [destinatario],
      RawMessage: {
        Data: anexo
      }
    },
    function (err, data) {
      if (err) {
        return callback(err);
      } else {
        return callback(null);
      }
    }
  );
};

if (!jasper.hm) {
  jasper.ready(next);
} else {
  next();
}