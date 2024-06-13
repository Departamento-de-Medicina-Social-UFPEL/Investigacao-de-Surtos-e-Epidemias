
var enviaEmail = function(mensagem) {
    AWS = require('aws-sdk');
    var destinatario = ['vanderson.th@gmail.com', 'tiagoalam@gmail.com'];
    var remetente = 'suporte.moodle.esf@gmail.com';
    AWS.config.loadFromPath('/home/dev/casca/configEmail.json');
    var ses = new AWS.SES();
    var titulo = "Cron horário casca Módulos";
    ses.sendEmail({
        Source: remetente,
        Destination: {
            ToAddresses: destinatario
        },
        Message: {
            Subject: {
                'Data': titulo,
                'Charset': 'utf-8'
            },
            Body: {
                Text: {
                    Data: mensagem,
                    Charset: 'utf-8'
                }
            }
        },
        ReplyToAddresses: [remetente],
        ReturnPath: remetente
    }, function(err, data) {
        if (err) {
            console.log('error', err);
            // retorno(err, self);
            return false;
        } else {
            // retorno(err, self);
            return true
        }
    });
}
var msg = '';
// tail -n 100 /home/duda/.forever/casca.log | grep erro -B 2 -A 10
const { spawn } = require('child_process');
const tail = spawn('tail', ['-n', '1000', '/home/vanderson/.forever/casca.log']);
const grep = spawn('grep', ['error', '-B', '10', '-A', '20']);

tail.stdout.on('data', (data) => {
  grep.stdin.write(data);
});

tail.stderr.on('data', (data) => {
  enviaEmail(data.toString());
});

tail.on('close', (code) => {
  if (code !== 0) {
    enviaEmail('tail process exited with code '.code);
  }
  grep.stdin.end();
});

grep.stdout.on('data', (data) => {
  console.log(data, '<br>');
  msg += data.toString();
});

grep.stderr.on('data', (data) => {
  enviaEmail(data.toString());
});

grep.on('close', (code) => {
  if (code !== 0) {
    msg = 'grep process exited with code '.code;
  }
  console.log('teste', code);
  enviaEmail(msg);
});