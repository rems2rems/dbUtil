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

fs = require 'fs'
Promise = require 'promise'

createView = require("./create_view")
            
module.exports = (db)->

    return new Promise((fulfill,reject)->

        fs.readdir (__dirname + "/views"),(err,filenames)=>
            
            if(err)
                reject(err)
                return

            promise = Promise.all(filenames.map((filename)->
                viewName = filename.split(".")[0]
                return createView db,"./views/"+viewName
                )
            )

            promise.then (views)->
                fulfill(views)
    )
    

            

