module.exports = 
    _id : '_design/beehouses'
    views :
        by_name :
            map : ((doc)-> 
                if doc.type == "beehouse"
                    emit doc.name,doc

                ).toString()

        by_apiary :
            map : ((doc)-> 
                if doc.type == "beehouse"
                    emit doc.apiary_id,doc

                ).toString()