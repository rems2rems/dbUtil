module.exports = (db,name,location)->
    
    apiary =
        _id : name
        name : name
        type : "apiary"

    if location?
        apiary.location_id = location._id
    
    return db.save apiary