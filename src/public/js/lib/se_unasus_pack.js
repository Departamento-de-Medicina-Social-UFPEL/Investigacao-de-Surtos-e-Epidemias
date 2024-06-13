// Biblioteca SE_UNASUS_PACK para Recursos Educacionais Interativos em HTML5
// Onivaldo Rosa Junior
// Secretaria Executiva da UNA-SUS
// Versão 1.0 (16/06/2015)
// Arquivo complementar obrigatório:
// - Arquivo de configuração do recurso: se_unasus_pack.json

function SE_UNASUS_PACK() {
	this._initialized = false;
}

SE_UNASUS_PACK.prototype.inicializar = function() {
	this._api = this._getAPI();
	this._error = false;
	if (this._api) {
		this.debugMessage("Adaptador SE_UNASUS_PLAYER_API encontrado.");
		if (this._api.config === null) {
			try {
				this._api.config = this._loadJSON("se_unasus_pack.json");
			} catch (error) {
				this.debugMessage(error);
				this._errorMessage = 'Não foi possível ler o arquivo de configuração.';
				this._error = true;
				return false;
			}
			this.debugMessage("Arquivo de configuração carregado.");
		}
		if (this._api.state === this._api._STATE.RUNNING) {
			this._initialized = true;
			return true;
		} else {
			try {
				this.debugMessage("Inicializando player.");
				if (!this._api.initialize()) {
					this._errorMessage = 'Não foi possível inicializar o player.';
					this._error = true;
					return false;
				}
			} catch (error) {
				this.debugMessage(error);
				this._errorMessage = 'Não foi possível inicializar o player.';
				this._error = true;
				return false;
			}
			this.debugMessage("Player inicializado.");
			this._initialized = true;
			return true;
		}
	} else {
		this._errorMessage = "Adaptador SE_UNASUS_PLAYER_API não encontrado.";
		this._error = true;
		return false;
	}
}

SE_UNASUS_PACK.prototype._findAPI = function(win) {
	var findAPITries = 0;
	try {
		while ((win.SE_UNASUS_PLAYER_API == null) && (win.parent != null) && (win.parent != win))
		{
			findAPITries++;
			if (findAPITries > 500)
			{
				this._errorMessage = 'Erro ao procurar API.';
				this.alertMessage(this._errorMessage);
			}
			win = win.parent;
	   }
	   return win.SE_UNASUS_PLAYER_API;
   } catch (e){
	   this._errorMessage = 'Erro ao procurar API, utilize outro navegador.';
	   this.alertMessage(this._errorMessage);
	   return null;
   }
}

SE_UNASUS_PACK.prototype._getAPI = function() {
	var theAPI = this._findAPI(window);
	if ((theAPI == null) && (window.opener != null) && (typeof(window.opener) != "undefined")) {
		theAPI = this._findAPI(window.opener);
	}
	if (theAPI == null) {
		return false;
	} else {
		return theAPI;
	}
}

SE_UNASUS_PACK.prototype._loadJSON = function(filePath) {
	var json = this._loadTextFileAjaxSync(filePath, "application/json");
	var load = JSON.parse(json);
	return load;
}

SE_UNASUS_PACK.prototype._loadTextFileAjaxSync = function(filePath, mimeType) {
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.open("GET",filePath,false);
	if (mimeType != null) {
		if (xmlhttp.overrideMimeType) {
			xmlhttp.overrideMimeType(mimeType);
		}
	}
	xmlhttp.send();
	if (xmlhttp.status==200) {
		return xmlhttp.responseText;
	} else {
		return null;
	}
}

SE_UNASUS_PACK.prototype.debugMessage = function(str) {
	if (this._initialized) {
		if (this._api.debug) {
			if (this._api) {
				try {
					this._api.debugMessage(str);
				} catch (error) {
					this.errorMessage('Não foi possível enviar informação de debug ao player.');
				}
			}
		return true;
		}
	}
	console.log('DEBUG: '+str);
	return false;
}

SE_UNASUS_PACK.prototype.errorMessage = function(error) {
	if (this._api) {
		try {
			this._api.setError(error);
		} catch (error2) {
			this.alertMessage('ERROR: Não foi possível enviar informação de erro ao player.');
			this.debugMessage(error2);
		}
	} else {
		console.log('ERROR: '+error);
	}
}

SE_UNASUS_PACK.prototype.alertMessage = function(str) {
	try {
		this._api.alert(str);
	} catch (e) {
		alert(str);
	}
}

SE_UNASUS_PACK.prototype.getConfig = function() {
	if (this._initialized) {
		return this._api.config;
	}
	this.alertMessage('ERROR: Player não inicializado 1.');
	return null;
}

SE_UNASUS_PACK.prototype.getBasename = function() {
	if (this._initialized) {
		return this._api.getBasename();
	}
	this.alertMessage('ERROR: Player não inicializado 2.');
	return null;
}

SE_UNASUS_PACK.prototype.getPlayerVersion = function() {
	if (this._initialized) {
		return this._api.getPlayerVersion();
	}
	this.alertMessage('ERROR: Player não inicializado 3.');
	return null;
}

SE_UNASUS_PACK.prototype.getPlayerName = function() {
	if (this._initialized) {
		return this._api.getPlayerName();
	}
	this.alertMessage('ERROR: Player não inicializado 4.');
	return null;
}

SE_UNASUS_PACK.prototype.getPlayerUser = function() {
	if (this._initialized) {
		return this._api.getPlayerUser();
	}
	this.alertMessage('ERROR: Player não inicializado 5.');
	return null;
}

SE_UNASUS_PACK.prototype.getPlayerUserRealName = function() {
	if (this._initialized) {
		return this._api.getPlayerUser().RealName;
	}
	this.alertMessage('ERROR: Player não inicializado 6.');
	return null;
}

SE_UNASUS_PACK.prototype.getPlayerUserId = function() {
	if (this._initialized) {
		return this._api.getPlayerUser().Id;
	}
	this.alertMessage('ERROR: Player não inicializado 7.');
	return null;
}

SE_UNASUS_PACK.prototype.getDebug = function() {
	if (this._initialized) {
		return this._api.debug;
	}
	this.alertMessage('ERROR: Player não inicializado 8.');
	return null;
}

SE_UNASUS_PACK.prototype.setDebug = function(debug) {
	if (this._initialized) {
		if (debug) {
			this._api.debug = true;
		} else {
			this._api.debug = false;
		}
		return true;
	}
	this.alertMessage('ERROR: Player não inicializado 9.');
	return null;
}

SE_UNASUS_PACK.prototype.getError = function() {
	return this._error;
}

SE_UNASUS_PACK.prototype.getErrorMessage = function() {
	return this._errorMessage;
}

SE_UNASUS_PACK.prototype.getVideoResolutions = function() {
	if (this._initialized) {
		return this._api.getVideoResolutions();
	}
	this.alertMessage('ERROR: Player não inicializado 11.');
	return null;
}

// seta um objeto persistente de nome item.
// a composição do objeto é variável, conforme a necessidade
// deve permitir a conversão utilizando JSON.stringify

SE_UNASUS_PACK.prototype.setPersistence = function(item, objeto) {
	if (this._initialized) {
		valor = JSON.stringify(objeto);
		if (this._api.setItem(this.getBasename() + item, valor)===false) {
			this.debugMessage("Erro: setPersistence"+"=>"+item+":"+valor);
			this._errorMessage = 'Não foi possível enviar dados ao player.';
		} else {
			this.debugMessage("Sucesso: setPersistence"+"=>"+item+":"+valor);
		}
		return true;
	}
	this.alertMessage('ERROR: Player não inicializado 12.');
	return null;
}

// retorna um objeto persistente, de nome item.
// a composição do objeto é variável, conforme a necessidade

SE_UNASUS_PACK.prototype.getPersistence = function(item) {
	if (this._initialized) {
		var valor = this._api.getItem(this.getBasename() + item);
		if (valor===false) {
			this.debugMessage("getPersistence"+"=>FALHA");
			this._errorMessage = 'Não foi possível ler dados do player.';
			return null;
		} else {
			try {
				var dataitem = JSON.parse(valor);
			} catch (e) {
				this.debugMessage("getPersistence"+"=>"+item+":null");
				return null;
			}
			this.debugMessage("getPersistence"+"=>"+item+":"+valor);
			return dataitem;
		}
	}
	this.alertMessage('ERROR: Player não inicializado 13.');
	return null;
}

// STATUS
// status.status => valor nominal textual do status podendo ter os seguintes valores "attended", "attempted", "completed", "passed", "failed"
// status.percentage => valor inteiro entre 0 e 100
// status.LTIvalue => valor ponto flutuante entre 0 e 1
// status.videoresolution => valor textual,  deve estar entre os valores disponíveis no recurso, com base no arquivo de configuração se_unasus_pack.json (exemplo "360p")
// Outras propriedades devem ser adicionadas ao status, conforme a necessidade da cada recurso, e documentadas no arquivo se_unasus_pack_dic.json

SE_UNASUS_PACK.prototype.setStatus = function(status) {
	if (this._initialized) {
		var status_values = ["attended", "attempted", "completed", "passed", "failed"];
		if (status_values.indexOf(status.status) === -1) {
			this.debugMessage("setStatus"+"=>FALHA (status)");
			this._errorMessage = 'valor status.status inválido.';
		}
		if (!(status.percentage>=0 && status.percentage<=100 && (status.percentage === +status.percentage && isFinite(status.percentage) && !(status.percentage % 1)))) {
			this.debugMessage("setStatus"+"=>FALHA (percentage)");
			this._errorMessage = 'valor status.percentage inválido.';
		}
		if (!(status.LTIvalue>=0 && status.LTIvalue<=1)) {
			this.debugMessage("setStatus"+"=>FALHA (LTIvalue)");
			this._errorMessage = 'valor status.LTIvalue inválido.';
		}
		return this.setPersistence("STATUS", status);
	}
	this.alertMessage('ERROR: Player não inicializado 14.');
	return null;
}

SE_UNASUS_PACK.prototype.getStatus = function() {
	if (this._initialized) {
		return this.getPersistence("STATUS");
	}
	this.alertMessage('ERROR: Player não inicializado 15.');
	return null;
}

window.unasus = window.unasus || {};
window.unasus.pack = window.unasus.pack || new SE_UNASUS_PACK();