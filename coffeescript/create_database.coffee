# Copyright 2012-2014 OpenBeeLab.
# This file is part of the OpenBeeLab project.

# The OpenBeeLab project is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# The OpenBeeLab project is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with OpenBeeLab.  If not, see <http://www.gnu.org/licenses/>.

createViews = require './create_views'
createUsers = require './create_users'
promisify_db = require './promisify_cradle'
Promise = require 'promise'

module.exports = (dbDriver,name)=>
    
    return new Promise((fulfill,reject)->

        db = dbDriver.database(name)
        db = promisify_db(db)

        usersDb = dbDriver.database("_users")
        usersDb = promisify_db(usersDb)

        db.create().then ()->

            createViews(db).then (views)->

                createUsers(usersDb,db,name).then ->

                    return fulfill(db)
    )