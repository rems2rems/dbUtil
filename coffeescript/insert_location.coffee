module.exports = (db,name,callback=->)->
    
    location =
        name : name
        type : "location"

    # if longitude? and latitude?
    #     location.longitude = longitude
    #     location.latitude = latitude
    
    db.save location,callback