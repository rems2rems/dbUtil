module.exports = (db,name,location,callback=->)->
    
    apiary =
        _id : name
        name : name
        type : "apiary"

    if location?
        apiary.location_id = location._id
    
    db.save apiary,callback