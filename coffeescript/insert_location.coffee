module.exports = (db,name,longitude,latitude)->
    
    location =
        _id : 'location:' + name
        name : name
        type : "location"
        longitude : longitude
        latitude : latitude
    
    return db.save location