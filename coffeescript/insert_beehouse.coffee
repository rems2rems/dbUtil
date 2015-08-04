
Promise = require 'promise'

module.exports = (db,apiary,model,name)->

    modelProm = db.save model

    beehouse =
        _id : "beehouse:" + name
        name : name
        type : "beehouse"
        apiary_id : apiary?._id
        model_id : model._id
        number_of_extra_boxes : 0

    beeProm = db.save(beehouse)

    return Promise.all([modelProm,beeProm]).then ->
        return [db,apiary,beehouse]