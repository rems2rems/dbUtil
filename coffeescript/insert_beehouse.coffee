module.exports = (db,apiary,name,model_id,callback=->)->
    
    beehouse =
        _id : name
        name : name
        type : "beehouse"
        apiary_id : apiary?._id
        model_id : model_id
        number_of_extra_boxes : 0

    db.save beehouse,callback

