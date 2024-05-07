var fs = require('fs');
module.exports = function(done) {

    var address, app, port, self;

    app = this.express;

    port = process.env.PORT || 21509;

    address = '0.0.0.0';

    self = this;

    require('http').createServer(app).listen(port, address, function() {
        var endpoint = this.address();
        self.websocketServer = this;
        console.log('listening on %s:%d', endpoint.address, endpoint.port);
        return done();
    });

}