// Generated by CoffeeScript 1.9.2
(function() {
  var cradle, promisify_db;

  cradle = require('cradle');

  promisify_db = require('./promisify_cradle');

  exports.configuredDriver = function(config) {
    return new cradle.Connection(config.protocol + '://' + config.host, config.port, config);
  };

  exports.database = function(config) {
    var db;
    db = this.configuredDriver(config).database(config.name);
    return db = promisify_db(db);
  };

}).call(this);
