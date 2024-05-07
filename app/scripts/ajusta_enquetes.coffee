User = require '../models/usuarios.coffee'
_ = require('lodash')
a = require('async')

consertaRespostas = (enquete, quest)->
    cond = {"#{enquete}":{$exists:true}}
    console.log 'buscando', cond
    User.find(cond, {'enquetes':1}).lean().exec (err, docs)->
        throw err if err
        console.log docs.length+': Encontrados \n'
        e_vars = enquete.split('.')

        docsResponderam = docs.filter (d)->
            e = d.enquetes[e_vars[1]][e_vars[2]]
            #console.log 'e',e, d, d.enquetes[e_vars[1]],d.enquetes[e_vars[1]][e_vars[2]], e_vars
            if not e['naodesejoresponder']
                return true
            else 
                return false
        console.log docsResponderam.length+': Responderam \n Antes:'
        #console.log docsResponderam[0].enquetes[e_vars[1]][e_vars[2]],' \n'
        docsResponderam = docsResponderam.map (u)->
            q = u.enquetes[e_vars[1]][e_vars[2]][quest]
            if quest is 'pergunta3' and e_vars[2] is 'cadastro'
                switch q
                    when '1'
                        q = '10'
                    when '2'
                        q = '9'
                    when '3'
                        q = '8'
                    when '4'
                        q = '7'
                    when '5'
                        q = '6'
                    when '6'
                        q = '5'
                    when '7'
                        q = '4'
                    when '8'
                        q = '3'
                    when '9'
                        q = '2'
                    when '10'
                        q = '1'
            else
                switch q
                    when 'opt1'
                        q = 'opt10'
                    when 'opt2'
                        q = 'opt9'
                    when 'opt3'
                        q = 'opt8'
                    when 'opt4'
                        q = 'opt7'
                    when 'opt5'
                        q = 'opt6'
                    when 'opt6'
                        q = 'opt5'
                    when 'opt7'
                        q = 'opt4'
                    when 'opt8'
                        q = 'opt3'
                    when 'opt9'
                        q = 'opt2'
                    when 'opt10'
                        q = 'opt1' 
            u.enquetes[e_vars[1]][e_vars[2]][quest] = q
            return u
        console.log 'todos ajustados, salvando...\n Depois:' #, docsResponderam[0].enquetes[e_vars[1]][e_vars[2]]
        iterador = (item, callback)->
            sets = {"enquetes":item.enquetes}
            #console.log '.'
            User.update {_id:item._id}, {$set:sets},{ multi: false }, (err,n)->
                throw err if err
                return callback(err)
        a.map docsResponderam, iterador, (err, r)->
            if err
                throw err
            else
                console.log '\n ok, fim' 
###
moduloId = '5669c5c4f9d50797d4f3b497'
moduloId = '5d8aab26afcdb9691fbbfdc0'
moduloId = '578e2fade70643d3bf9989ca'
moduloId = '57dfe938e70643d3bf9999c9'
moduloId = '57dfedd7e70643d3bf9999cc'
###

moduloId = '59a0be22a8b9ce7531974290'



enqueteX = "enquetes."+moduloId+".cadastro"
questX = 'pergunta3'
consertaRespostas(enqueteX,questX)

###
 moduloId = '60aac8d581f2716bcc84c49f'
enqueteY = "enquetes."+moduloId+".conclusao"
questY = 'pergunta5'
consertaRespostas(enqueteY, questY) 
###