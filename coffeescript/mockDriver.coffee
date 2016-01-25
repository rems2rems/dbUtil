require('../../openbeelab-util/javascript/stringUtils').install()
promisify_db = require './promisify_dbDriver'
util = require 'util'

exports.dbs = dbs =
    _users : {}

                
exports.connectToServer = (config) ->

    updateViews = (db)->
        
        for own name,view of db.views
            # console.log "name:" + name
            # console.log("emit:" + key);
            emit = (key,value) ->  isEmitted = true; outKey = key; outValue = value
            ev = "mapFunc = (" + view['map'] + ')'
            # console.log ev
            eval(ev)
            #if view['reduce']?
            #    eval("reduceFunc = (" + view['reduce'] + ').bind(this)')
                            
            # eval("mapFunc = " + view.map.bind(@)

            docs = []
            for own _,candidate of db.data when not candidate._id.startsWith('_design/')
                
                console.log "candidate:" + candidate._id
                isEmitted = false
                outKey = null
                outValue = null
                
                mapFunc(candidate)
                console.log "key:" + outKey + "," + outValue + "," + isEmitted
                if isEmitted
                    docs.push {key: key, value: value}

                #if reduceFunc?
                #    reduceFunc(docs)

            #res = docs.pluck('value')
            db.views[name].data = {total_rows : docs.length, rows: docs }

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
                    
                    console.log "==============="
                    console.log doc
                    console.log "-- db avant ---"
                    console.log util.inspect(db,true,3,true)
                    
                    db.data[doc._id] = doc
                    
                    console.log "---------------"
                    console.log util.inspect(db,true,5,true)
                    console.log "==============="
                    console.log ""

                    if doc._id.startsWith '_design'

                        for own name,mapreduce of doc.views

                            name = doc._id + '/_view/' + name

                            view = { map: mapreduce['map'] , reduce: mapreduce['reduce'], data : []}
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

                    console.log "==============="
                    console.log id
                    console.log "-- db ----- ---"
                    console.log util.inspect(db,true,5,true)
                    console.log "==============="
                    
                    if id?.startsWith '_design/'
                        # console.log id
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
