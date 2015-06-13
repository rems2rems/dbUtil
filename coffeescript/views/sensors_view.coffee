module.exports = 
    _id : '_design/sensors'
    views :

        by_name :
            map : ((doc)-> 
                if doc.type == "sensor"
                    emit doc.name,doc

                ).toString()

        by_beehouse :
            map : ((doc)-> 
                if doc.type == "sensor"
                    emit doc.beehouse_id,doc

                ).toString()