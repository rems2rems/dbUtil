<<<<<<< HEAD
module.exports = (db,name,longitude,latitude)->
=======
module.exports = (db,name)->
>>>>>>> 85aa34f0bdbfe3ce2fbff4c90655bd0a63a573d1
    
    location =
        _id : 'location:' + name
        name : name
        type : "location"
        longitude : longitude
        latitude : latitude
    
    return db.save location