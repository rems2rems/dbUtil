require('../../openbeelab-util/javascript/stringUtils').install()
promisify_db = require './promisify_dbDriver'
util = require 'util'



docs = []

emit = (key,value) -> docs.push {key: key, value : value}
exports.dbs = dbs =
    _users : {}

                
exports.connectToServer = (config) ->

    updateViews = (db)->
        
        for own name,view of db.views

            docs = []
            for own _,candidate of db.data when not candidate._id.startsWith('_design/')
                
                view.map.bind(@).call(@,candidate)
            
            db.views[name].data = {total_rows : docs.length, rows: docs.clone() }

    return {

        database : (name)->

            db = dbs[name]
            
            return {

                exists : (callback)->

                    callback(null,dbs?[name]?)

                create : (callback)->

                    if db?
                        callback('db exists.')
                    else
                        db = dbs[name] = {views:{},data:{}}
                        callback(null)

                save : (doc,callback)->
                    
                    if not doc._id?
                        doc._id = String.generateToken(6)

                    rev = 0
                    if doc._rev?
                        [rev,_] = doc._rev.split("-")
                    rev += 1
                    doc._rev = rev + "-" + String.generateToken(6)
                    
                    db.data[doc._id] = doc
                    
                    if doc._id.startsWith '_design'

                        mapFunc = null
                        for own name,mapreduce of doc.views

                            name = doc._id + '/_view/' + name
                            eval("mapFunc = " + mapreduce['map'] + ';')
                            
                            do (mapFunc)->
                            
                                view = { map: mapFunc , reduce: mapreduce['reduce'], data : []}
                                db.views[name] = view

                    updateViews(db)
                    
                    callback(null,doc)

                remove : (doc,callback)->
                    
                    if not db?.data[doc?._id]?
                        callback("doc doesn't exist.",{ok:false})

                    [rev,_] = doc._rev.split("-")
                    rev += 1
                    delDoc = {}
                    delDoc._id = doc._id
                    delDoc._rev = rev + "-" + String.generateToken(6)
                    delDoc._deleted = true

                    db.data[doc._id] = delDoc
                    callback(null,{ok:true})

                get : (id,callback)->

                    if id?.startsWith '_design/'
                        
                        callback(null,db.views[id].data)
                    else

                        doc = null
                        if not db?.data[id]?._deleted
                            doc = db?.data[id] 
                        callback(null,doc)
            }

        useDb : (name)->
    
            return promisify_db(@database(name))

    }
