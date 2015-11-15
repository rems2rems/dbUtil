module.exports =
    _id : "dataSchema"
    type : "dataSchema"
    version : "1.0"
    views : {}
    schemas : [
        comments : "the apiary object"
        name : "apiary"
        properties : [
            name : "name"
            type : "string"
            required : true
            ,
            name : "type"
            type : "string"
            required : true
            value : "apiary"
            ,
            name : "location"
            properties : [
                name : "_id"
                type : "docId"
                required : true
                ,
                name : "name"
                type : "string"
                required :false
            ]
        ]
        ,
        comments : "the geographic location object. 
        latitude and longitude can be noised. in this case, the locationType is noisedGPS and the noise property is set.
        a not-noised location object can be linked to a noised version"
        name : "location"
        properties : [
            name : "type"
            type : "string"
            required : true
            value : "location"
            ,
            name : "name"
            type : "string"
            required : false
            ,
            name : "locationType"
            type : "string"
            required : true
            options : ["GPS","noisedGPS"]
            ,
            name : "latitude"
            type : "number"
            required : true
            minimum : -90.0
            maximum : 90.0
            ,
            name : "longitude"
            type : "number"
            required : true
            minimum : -180.0
            maximum : 180.0
            ,
            name : "noisedLocation"
            type : "docId"
            required : false
            ,
            name : "noise"
            type : "number"
            required : false
            minimum : -90.0
            maximum : 90.0
        ]
        ,
        comments : "the beehouse object"
        name : "beehouse"
        properties : [
            name : "type"
            type : "string"
            required : true
            value : "beehouse"
            ,
            name : "name"
            type : "string"
            required : true
            ,
            name : "apiary"
            properties : [
                name : "_id"
                type : "docId"
                required : true
                ,
                name : "name"
                type : "string"
                required :false
            ]
            ,
            name : "model"
            required : false
            properties : [
                name : "_id"
                type : "docId"
                required : true
                ,
                name : "name"
                type : "string"
                required :false
            ]
            ,
            name : "number_of_extra_boxes"
            type : "integer"
            required : false
            minimum : 0
        ]
    ]