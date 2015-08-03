module.exports = (db,apiary,name,model_id)->
    
    beehouse =
        _id : "beehouse:" + name
        name : name
        type : "beehouse"
        apiary_id : apiary?._id
        model_id : model_id
        number_of_extra_boxes : 0

    return db.save beehouse