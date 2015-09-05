// Generated by CoffeeScript 1.9.2
(function() {
  var Promise;

  Promise = require('promise');

  require('../../openbeelab-util/javascript/stringUtils').install();

  require('../../openbeelab-util/javascript/objectUtils').install();

  module.exports = function(db, location) {
    var noised, noisedPromise;
    location._id = 'location:' + String.generateToken(6);
    location.type = "location";
    noisedPromise = Promise.resolve();
    if (location.create_noised_area != null) {
      delete location.create_noised_area;
      noised = location.clone();
      noised._id += "_noised";
      noised.name = noised._id;
      noised.longitude += Number.getRandomArbitrary(-1.0 * location.noise / 2.0, location.noise / 2.0);
      noised.latitude += Number.getRandomArbitrary(-1.0 * location.noise / 2.0, location.noise / 2.0);
      noised.locationType = "noisedGPS";
      delete location.noise;
      noisedPromise = noisedPromise.then(function() {
        return db.save(noised).then(function(res) {
          return location.noisedLocation = res._id;
        });
      });
    }
    return noisedPromise.then(function() {
      return db.save(location).then(function() {
        return [db, location];
      });
    });
  };

}).call(this);
