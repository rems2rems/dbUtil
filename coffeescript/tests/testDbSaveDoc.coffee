
expect = require 'must'
require('../../../openbeelab-util/javascript/objectUtils').install()
require('../../../openbeelab-util/javascript/arrayUtils').install()


promisify_db = require '../promisify_dbDriver'

dbDriver = require('../mockDriver')
Promise = require 'promise'


config =
    
    database :

        name : 'test'
        host : 'dev.openbeelab.org'
        #host : 'localhost'
        protocol : 'http'
        port : 5984
        auth:
            username: 'admin'
            password: 'c0uch@dm1n'

db = dbDriver.connectToServer(config.database).useDb(config.database.name)

describe "a mock db",->

    it "should be able to save a doc", (done)->

        doc =
            _id : 'testDoc'
            type : 'aType'

        db.create()
        .then ()->

            db.save doc

        .then ()->
            
            db.get 'aType'
            .then (doc)->

                doc._id.must.be('testDoc')
                doc.type.must.be('aType')
                
                db.get 'aType'

        done()
