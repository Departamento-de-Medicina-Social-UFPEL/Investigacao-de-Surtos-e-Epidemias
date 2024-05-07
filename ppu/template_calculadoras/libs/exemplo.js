/**
 * Biblioteca de exemplo para manipulação de Recursos Educacionais Interativos em HTML5
 * @author Onivaldo Rosa Junior 
 * @copyright Secretaria Executiva da UNA-SUS 2016
 * @version 1.0.0
 * @requires se_unasus_pack.js 
 * @requires se_unasus_pack.json
 * @license GPLv3
 */

function criarStatusDefault() {

    var status_def = new Object();
	// Obrigatórios
    status_def.status = "attended";
    status_def.percentage = 0;
    status_def.LTIvalue = 0;
	// Adicionais para o exemplo
	
	status_def.visualizado = 0;
	
    unasus.pack.setStatus(status_def);

    return status_def;
}

function calcula_percentagem(visualizado) {
	var perc = 0;
	if (visualizado & 1) perc+=10;
	if (visualizado & 2) perc+=25;
	if (visualizado & 4) perc+=25;
	if (visualizado & 8) perc+=25;
	if (visualizado & 16) perc+=15;
	return perc;
}

function visualizado(item) {

	var status = unasus.pack.getStatus();
	
    if (status === undefined) {
		console.log('criaStatus');
        status = criarStatusDefault();
    }

    if (status === null) {
        return false;
    }
	
	visualizado_old = status.visualizado;
	
	switch(item) {
		case 'inicio':
			status.visualizado = status.visualizado | 1;
			break;
		case 'html5':
			status.visualizado = status.visualizado | 2;
			break;
		case 'criando_ppu':
			status.visualizado = status.visualizado | 4;
			break;
		case 'executando_ppu':
			status.visualizado = status.visualizado | 8;
			break;
		case 'avaliacao':
			status.visualizado = status.visualizado | 16;
			break;
			
	} 
	
	if (status.visualizado != visualizado_old) {
		console.log('setStatus');
		var p = calcula_percentagem(status.visualizado);
	
		status.percentage = p;
		status.LTIvalue = p/100;
	
		var result = unasus.pack.setStatus(status);
		
		if (result === true) {			
			return status.percentage;
		} else {
			return false;
		}			
		
	} else {
		console.log('NotSetStatus');
		return status.percentage;
	}
		
}