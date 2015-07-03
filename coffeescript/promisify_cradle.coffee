Promise = require 'promise'

module.exports = (db)->

    get = Promise.denodeify db.get.bind(db)
    save = Promise.denodeify db.save.bind(db)
    save = (obj) -> console.log("saving obj"); return Promise.resolve("ok") 
    create = Promise.denodeify db.create.bind(db)
    
    return {

        get : get
        save : save
        create : create
    }