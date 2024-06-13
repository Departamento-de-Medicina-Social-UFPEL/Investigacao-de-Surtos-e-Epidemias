// Generated by CoffeeScript 2.7.0
var indexOf = [].indexOf;

define([], function() {
  var DataPTBR, fetch, isEmail, pad, pretty, validaCPF;
  pretty = {
    dig: function(str) {
      var dig;
      str = str.trim();
      dig = str.match(/\d/g);
      if (dig !== null) {
        dig = dig.join("");
        return dig;
      }
      return "";
    },
    name: function(str) {
      var exc;
      exc = ["de", "da", "do", "dos", "das", "e", "las", "del", "los", "y", "delas", "delos"];
      return str.replace(/\s{2,}/g, " ").trim().split(" ").map(function(a) {
        a = a.toLowerCase();
        if (indexOf.call(exc, a) >= 0) {
          return a;
        } else {
          return a.substr(0, 1).toUpperCase() + a.substr(1);
        }
      }).join(" ");
    },
    tel: function(digs) {
      var dig;
      dig = pretty.dig(digs);
      if (dig.length >= 10) {
        return "(" + dig.substr(0, 2) + ") " + dig.substr(2, 4) + "-" + dig.substr(6, 4);
      } else {
        return digs;
      }
    },
    cpf: function(digs) {
      var dig;
      dig = pretty.dig(digs);
      if (dig.length === 11) {
        return dig.substr(0, 3) + "." + dig.substr(3, 3) + "." + dig.substr(6, 3) + '-' + dig.substr(9, 2);
      } else {
        return digs;
      }
    }
  };
  fetch = {
    name: function(n) {
      return pretty.name(n.primeiro + " " + n.sobrenome);
    },
    idade: function(i) {
      var age, birthDate, m, today;
      i = i.split("/").map(function(a, i, is_) {
        if (i === 0) {
          return is_[1];
        } else {
          if (i === 1) {
            return is_[0];
          } else {
            return is_[2];
          }
        }
      }).join("/");
      today = new Date();
      birthDate = new Date(i);
      age = today.getFullYear() - birthDate.getFullYear();
      m = today.getMonth() - birthDate.getMonth();
      if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
        age--;
      }
      return age;
    }
  };
  validaCPF = function(cpf) {
    var i, rest, sum;
    sum = 0;
    if (cpf === "00000000000") {
      return false;
    }
    i = 1;
    while (i <= 9) {
      sum = sum + parseInt(cpf.substring(i - 1, i)) * (11 - i);
      i++;
    }
    rest = (sum * 10) % 11;
    if ((rest === 10) || (rest === 11)) {
      rest = 0;
    }
    if (rest !== parseInt(cpf.substring(9, 10))) {
      return false;
    }
    sum = 0;
    i = 1;
    while (i <= 10) {
      sum = sum + parseInt(cpf.substring(i - 1, i)) * (12 - i);
      i++;
    }
    rest = (sum * 10) % 11;
    if ((rest === 10) || (rest === 11)) {
      rest = 0;
    }
    if (rest !== parseInt(cpf.substring(10, 11))) {
      return false;
    }
    return true;
  };
  pad = function(str, num = 11, end = false, char = '0') {
    str = pretty.dig(str);
    char = String(char);
    while (str.length < num) {
      str = !end ? char + str : str + char;
    }
    return str;
  };
  isEmail = function(email) {
    var exclude;
    exclude = /^[a-zA-Z0-9][a-zA-Z0-9\._-]+@([a-zA-Z0-9\._-]+\.)[a-zA-Z-0-9]+/;
    if (email.search(exclude) === -1 || email.indexOf(',') > -1 || email.indexOf(';') > -1) {
      return false;
    } else {
      return true;
    }
  };
  DataPTBR = function(ts) {
    var o;
    this.dias = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"];
    this.meses = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];
    this.timestamp = ts * 1000;
    this.charMes = 3;
    this.charDia = 0;
    this.comFeira = false;
    o = arguments[1];
    if (typeof o === "object") {
      this.charMes = (o.charMes !== undefined ? o.charMes : this.charMes);
      this.charDia = (o.charDia !== undefined ? o.charDia : this.charDia);
      this.comFeira = (o.comFeira !== undefined ? o.comFeira : this.comFeira);
    }
    this.fabricate = function() {
      var dia, theDia, theMes;
      this.data = new Date(this.timestamp);
      dia = this.data.getDay();
      theDia = this.dias[dia];
      theMes = this.meses[this.data.getMonth()];
      if (this.charDia > 0) {
        theDia = theDia.substring(0, this.charDia);
      }
      if (this.charMes > 0) {
        theMes = theMes.substring(0, this.charMes);
      }
      if (this.comFeira && dia !== 0 && dia !== 6) {
        theDia += "-feira";
      }
      return {
        data: this.data,
        dia: theDia,
        mes: theMes
      };
    };
    return this;
  };
  return {
    pretty: pretty,
    fetch: fetch,
    valCPF: validaCPF,
    isEmail: isEmail,
    databr: DataPTBR,
    pad: pad
  };
});