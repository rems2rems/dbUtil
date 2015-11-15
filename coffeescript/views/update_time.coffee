module.exports =

    _id : '_design/updates'

    views : {}
    updates : 

        time : ((doc, req)->

            if not doc.server_timestamp
                doc.server_timestamp = (new Date()).toISOString()
            
            return [doc,'server timestamp ok for object ' + req.id]
            
        ).toString()