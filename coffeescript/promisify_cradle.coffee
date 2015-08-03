Promise = require 'promise'
require('../../openbeelab-util/javascript/stringUtils').install()

module.exports = (db)->

    get = Promise.denodeify db.get.bind(db)
    save = Promise.denodeify db.save.bind(db)
    save = (obj) ->

    	console.log("saving obj")
    	if not obj._id? or obj._id is null
    		console.log "generating id.."
    		obj._id = String.generateToken(6)
    	return Promise.resolve(obj)

    create = Promise.denodeify db.create.bind(db)
    
    return {

        get : get
        save : save
        create : create
    }