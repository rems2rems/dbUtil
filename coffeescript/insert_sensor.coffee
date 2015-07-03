module.exports = (db,beehouse,pin,bias,gain,name,unit)->
    
    sensor =
        name : name
        type : "sensor"
        beehouse_id : beehouse._id
        pin : pin
        gain : gain
        bias : bias
        unit : unit

    return db.save sensor

