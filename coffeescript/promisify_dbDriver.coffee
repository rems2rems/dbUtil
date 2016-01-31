Promise = require 'promise'
require('../../openbeelab-util/javascript/stringUtils').install()

module.exports = (db)->

    get = Promise.denodeify db.get.bind(db)
    save = Promise.denodeify db.save.bind(db)
    create = Promise.denodeify db.create.bind(db)
    exists = Promise.denodeify db.exists.bind(db)
    remove = Promise.denodeify db.remove.bind(db)
    
    return {

        get : get
        save : save
        create : create
        exists : exists
        remove : remove
        reset : db.reset
        addServerTimestamp : (obj)->
            add_server_timestamp =
                _id : "_design/updates/_update/time/" + obj._id
            
            @save(add_server_timestamp)
    }
