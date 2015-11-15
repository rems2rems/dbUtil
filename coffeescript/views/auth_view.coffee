module.exports =

    _id : '_design/auth'

    views : {}
    validate_doc_update : ((newDoc, oldDoc, userCtx)->

        updated = oldDoc isnt null
        deleted = newDoc['deleted'] || newDoc['_deleted']
        
        isLogged = userCtx.name? and userCtx.name != ''
        
        if ((deleted || updated) && !isLogged )
            throw({'forbidden': 'please log in.'})

    	).toString()