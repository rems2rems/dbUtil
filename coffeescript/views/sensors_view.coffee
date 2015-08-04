module.exports = 
    _id : '_design/stands'
    views :

        by_name :
            map : ((doc)-> 
                if doc.type == "stand"
                    emit doc.name,doc

                ).toString()

        by_apiary :
            map : ((doc)-> 
                if doc.type == "stand"
                    emit doc.apiary_id,doc

                ).toString()