// Generated by CoffeeScript 1.9.2
(function() {
  module.exports = function(db, stand, apiary, beehouse) {
    stand._id = 'stand:' + stand.name;
    stand.apiary_id = apiary != null ? apiary._id : void 0;
    stand.beehouse_id = beehouse != null ? beehouse._id : void 0;
    return db.save(stand);
  };

}).call(this);