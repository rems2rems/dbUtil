
module.exports = (db,location,name)->

    apiary =
        _id : "apiary:" + name
        name : name
        type : "apiary"

    apiary.location_id = location?._id
    
    db.save(apiary).then ->

        return [db,apiary]