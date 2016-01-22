
expect = require 'must'
require('../../openbeelab-util/javascript/objectUtils').install()
require('../../openbeelab-util/javascript/arrayUtils').install()


promisify_db = require './promisify_dbDriver'

dbDriver = require('./mockDriver')
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

    it "should deal with views", (done)->

        view = 
            _id : '_design/stands'
            views :
                all :
                    map : ((doc)-> 
                        if doc.type == "stand"
                            emit doc._id,doc

                        ).toString()

        db.create()
        .then ()->

            db.save view

        .then ()->
            
            db.save {type : 'stand', name:'test_stand'}
        .then ()->
            
            db.save {type : 'location', name:'test_location'}

        .then ()->

            db.get '_design/stands/_view/all'
            .then (data)->

                data.total_rows.must.be(1)
                data.rows[0].key.name.must.be('test_stand')

        done()
