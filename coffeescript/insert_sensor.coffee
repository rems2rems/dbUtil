<<<<<<< HEAD
require('../../openbeelab-util/javascript/stringUtils').install()

module.exports = (db,beehouse,device,measureType,pin,bias,gain,name,unit)->
=======
module.exports = (db,beehouse,pin,bias,gain,name,unit)->
>>>>>>> 85aa34f0bdbfe3ce2fbff4c90655bd0a63a573d1
    
    sensor =
    	_id : "sensor:" + name + "_" + String.generateToken(6)
        name : name
        type : "sensor"
        beehouse_id : beehouse._id
        device : device
        measureType : measureType
        pin : pin
        gain : gain
        bias : bias
        unit : unit

    return db.save sensor

