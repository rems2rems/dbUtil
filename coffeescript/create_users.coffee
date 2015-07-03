require '../../openbeelab-util/javascript/numberUtils'
arrayUtils = require '../../openbeelab-util/javascript/arrayUtils'
mixin = require '../../openbeelab-util/javascript/mixin'
mixin.include Array,arrayUtils

generatePassword = ->

    password = ""
    6.times ->

        letter = ['a'..'z'].pickRandom()[['toLowerCase','toUpperCase'].pickRandom()]()
        digit = [0..9].pickRandom()
        password += [letter,digit].pickRandom()

    return password

module.exports = (usersDb,db,dbName)->

    dbAdmin =
        _id : 'org.couchdb.user:'+dbName+'_admin'
        type : "user"
        name : dbName+'_admin'
        roles : ["admin"]
        password : generatePassword()

    console.log "dbAdmin login:"+dbAdmin.name
    console.log "dbAdmin password:"+dbAdmin.password
    
    usersDb.save dbAdmin

    dbUploader =

        _id : 'org.couchdb.user:'+dbName+'_uploader'
        type : "user"
        name : dbName+'_uploader'
        roles : []
        password : generatePassword()

    console.log "dbUploader login:"+dbUploader.name
    console.log "dbUploader password:"+dbUploader.password

    usersDb.save dbUploader

    security_doc =
        _id : '_security'
        admins :
            names : [dbAdmin.name]
            roles : []
        members :
            names : [dbUploader.name]
            roles : []

    #todo: create an "all" promise with admin and uploader promises
    return db.save security_doc

    