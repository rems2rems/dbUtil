module.exports = (db,name)->
    
    location =
        name : name
        type : "location"

    # if longitude? and latitude?
    #     location.longitude = longitude
    #     location.latitude = latitude
    
    return db.save location