module.exports = function () {
  // Configure view-related settings.  Consult the Express API Reference for a
  // list of the available [settings](http://expressjs.com/api.html#app-settings).
  this.set("views", __dirname + "/../../app/views");
  this.set("view engine", "ejs");

  // Register EJS as a template engine.
  this.engine("ejs", require("ejs").__express);

  // Override default template extension.  By default, Locomotive finds
  // templates using the `name.format.engine` convention, for example
  // `index.html.ejs`  For some template engines, such as Jade, that find
  // layouts using a `layout.engine` notation, this results in mixed conventions
  // that can cause confusion.  If this occurs, you can map an explicit
  // extension to a format.
  /* this.format('html', { extension: '.jade' }) */

  // Register formats for content negotiation.  Using content negotiation,
  // different formats can be served as needed by different clients.  For
  // example, a browser is sent an HTML response, while an API client is sent a
  // JSON or XML response.
  /* this.format('xml', { engine: 'xmlb' }); */
};
