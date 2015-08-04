
module.exports = (db,stand,apiary,beehouse)->
        
    stand._id = 'stand:'+stand.name
    stand.apiary_id = apiary?._id
    stand.beehouse_id = beehouse?._id

    return db.save(stand)