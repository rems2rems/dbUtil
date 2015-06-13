module.exports = (db,callback=->)->

    dadant =
        _id : "dadant"
        name : "dadant"
        type : "beehouse_model"
        model : "dadant"
        weight :
            value : 37
            unit : "Kg"
        extra_box_weight :
            value : 5
            unit : "Kg"

    db.save dadant,callback

