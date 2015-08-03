
require('../../openbeelab-util/javascript/stringUtils').install()

Promise = require 'promise'

module.exports = (usersDb,db,dbName)->

    dbAdmin =
        _id : 'org.couchdb.user:'+dbName+'_admin'
        type : "user"
        name : dbName+'_admin'
        roles : ["admin"]
        password : String.generateToken(6)

    console.log "dbAdmin login:"+dbAdmin.name
    console.log "dbAdmin password:"+dbAdmin.password
    
    adminPromise = usersDb.save dbAdmin

    dbUploader =

        _id : 'org.couchdb.user:'+dbName+'_uploader'
        type : "user"
        name : dbName+'_uploader'
        roles : []
        password : String.generateToken(6)

    console.log "dbUploader login:"+dbUploader.name
    console.log "dbUploader password:"+dbUploader.password

    uploaderPromise = usersDb.save dbUploader

    security_doc =
        _id : '_security'
        admins :
            names : [dbAdmin.name]
            roles : []
        members :
            names : [dbUploader.name]
            roles : []

    securityPromise = Promise.all [adminPromise,uploaderPromise]
    securityPromise.then ->
        db.save security_doc
    
    return securityPromise

    