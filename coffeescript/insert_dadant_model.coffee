module.exports = (db,callback=->)->

    dadant =
        _id : "beehousemodel:dadant"
        name : "dadant"
        type : "beehouse_model"
        model : "dadant"
        weight :
            value : 37
            unit : "Kg"
        extra_box_weight :
            value : 5
            unit : "Kg"

    return db.save dadant

