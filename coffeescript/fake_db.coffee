require '../../common/javascript/stringUtils'

db = {}
db.save = (doc,callback)->
    
    console.log "doc saved"
    callback()

db.get = (id,callback)->

    doc = {}
    doc._id = id
    doc._rev = "1"
    if id.contains("sensor")
        doc.type = "beehouse_sensor"
        doc.measure_type = 'weight'
        doc.bias = 157
        doc.gain = 0.176
        doc.unit = 'kg'
        doc.pin = 5

    callback(null,doc)

module.exports = db