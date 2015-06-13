module.exports = 
    _id : '_design/apiaries'
    views :
        by_name :
            map : ((doc)-> 
                if doc.type == "apiary"
                    emit doc.name,doc

                ).toString()

        by_location :
            map : ((doc)-> 
                if doc.type == "apiary"
                    emit doc.location_id,doc

                ).toString()