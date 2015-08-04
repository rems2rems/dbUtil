Promise = require 'promise'
require('../../openbeelab-util/javascript/stringUtils').install()

module.exports = (db)->

    get = Promise.denodeify db.get.bind(db)
    save = Promise.denodeify db.save.bind(db)
    create = Promise.denodeify db.create.bind(db)
    exists = Promise.denodeify db.exists.bind(db)
    
    return {

        get : get
        save : save
        create : create
        exists : exists
    }