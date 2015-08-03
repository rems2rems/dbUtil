<<<<<<< HEAD
=======
require '../../openbeelab-util/javascript/numberUtils'
arrayUtils = require '../../openbeelab-util/javascript/arrayUtils'
mixin = require '../../openbeelab-util/javascript/mixin'
mixin.include Array,arrayUtils
>>>>>>> 85aa34f0bdbfe3ce2fbff4c90655bd0a63a573d1

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

<<<<<<< HEAD
    uploaderPromise = usersDb.save dbUploader
=======
    usersDb.save dbUploader
>>>>>>> 85aa34f0bdbfe3ce2fbff4c90655bd0a63a573d1

    security_doc =
        _id : '_security'
        admins :
            names : [dbAdmin.name]
            roles : []
        members :
            names : [dbUploader.name]
            roles : []

<<<<<<< HEAD
    securityPromise = Promise.all [adminPromise,uploaderPromise]
    securityPromise.then ->
        db.save security_doc
    
    return securityPromise
=======
    #todo: create an "all" promise with admin and uploader promises
    return db.save security_doc
>>>>>>> 85aa34f0bdbfe3ce2fbff4c90655bd0a63a573d1

    