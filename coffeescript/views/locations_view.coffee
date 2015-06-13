module.exports = 
    _id : '_design/locations'
    views :
        by_name :
            map : ((doc)-> 
                if doc.type == "location"
                    emit doc.name,doc

                ).toString()