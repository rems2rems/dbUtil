
expect = require 'must'
require('../../../openbeelab-util/javascript/objectUtils').install()
require('../../../openbeelab-util/javascript/arrayUtils').install()
util = require 'util'

promisify_db = require '../promisify_dbDriver'

dbDriver = require('../mockDriver')
Promise = require 'promise'

config =
    
    database :

        name : 'test'

db = dbDriver.connectToServer(config.database).useDb(config.database.name)

describe "a mock db",->

    it "should deal with views", (done)->

        standsView =
            _id : '_design/stands'
            views :
                all :
                    map : ((doc)->
                        if doc.type == "stand"
                            
                            emit doc._id,doc

                        ).toString()

        locsView =
            _id : '_design/locs'
            views :
                all :
                    map : ((doc)->
                        if doc.type == "location"
                            
                            emit doc._id,doc

                        ).toString()

        db.create()
        .then ()->

            db.save standsView

        .then ()->

            db.save locsView

        .then ()->
            
            db.save { _id : "test_stand", type : 'stand', name:'a test stand'}

        .then ()->
            
            db.save { _id: 'test_location', type : 'location', name:'a test location'}

        .then ()->

            db.get '_design/stands/_view/all'
            .then (data)->
                
                expect(data).to.not.be.null()
                expect(data.total_rows).to.be.a.number()
                data.total_rows.must.be(1)
                
                data.rows[0].key.must.be('test_stand')
                data.rows[0].value.type.must.be("stand")

        .then ()->

            db.get '_design/locs/_view/all'
            .then (data)->
                
                expect(data).to.not.be.null()
                expect(data.total_rows).to.be.a.number()
                data.total_rows.must.be(1)
                
                data.rows[0].key.must.be('test_location')
                data.rows[0].value.type.must.be("location")

                done()
        
        .catch (err)->
            
            done(err)
