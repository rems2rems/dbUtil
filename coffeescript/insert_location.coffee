
Promise = require 'promise'
require('../../openbeelab-util/javascript/stringUtils').install()
require('../../openbeelab-util/javascript/objectUtils').install()

module.exports = (db,location)->

    location._id = 'location:' + String.generateToken(6)
    location.type = "location"
    
    noisedPromise = Promise.resolve()
    if location.create_noised_area?
        delete location.create_noised_area
        
        noised = location.clone()
        noised._id += "_noised"
        noised.name = noised._id
        noised.longitude += Number.getRandomArbitrary(-1.0*location.noise/2.0,location.noise/2.0)
        noised.latitude  += Number.getRandomArbitrary(-1.0*location.noise/2.0,location.noise/2.0)
        noised.locationType = "noisedGPS"
        delete location.noise
        
        noisedPromise = noisedPromise.then -> 

            db.save(noised).then (res) ->

                location.noisedLocation = res._id

    noisedPromise.then -> 
        db.save(location).then ->
            return [db,location]