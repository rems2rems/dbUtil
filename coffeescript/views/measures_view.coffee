module.exports = 
    _id : '_design/measures'
    views :
        by_location :
            map : ((doc)-> 
                if doc.type == "measure"
                    emit doc.location_id,doc

                ).toString()

        by_date :
            map : ((doc)-> 
                if doc.type == "measure"
                    emit doc.timestamp,doc

                ).toString()

        by_name :
            map : ((doc)-> 
                if doc.type == "measure"
                    emit doc.name,doc

                ).toString()

        by_location_and_date_and_name :
            map : ((doc)-> 
                if doc.type == "measure"
                    emit [doc.location_id,doc.timestamp,doc.name],doc

                ).toString()

        by_location_and_date_and_beehouse :
            map : ((doc)-> 
                if doc.type == "measure"
                    emit [doc.location_id,doc.timestamp,doc.beehouse_id],doc

                ).toString()

        beehouse_weight_by_hour :

            map : ((doc)-> 
                if doc.type == "measure" and doc.beehouse_id isnt null and doc.name is "global-weight"
                    hourTime = doc.timestamp.split(":")[0]
                    emit(hourTime, [hourTime,doc.value,1])

                ).toString()

            reduce : ((key,values,rereduce)-> 
                time = values[0][0]

                weights = values.map (v)-> v[1]
                factors = values.map (v)-> v[2]
                totalFactors = sum(factors)

                totalWeight = 0
                for weight,i in weights
                    totalWeight += weight*factors[i]
                totalWeight = totalWeight/totalFactors
                return [time,totalWeight,totalFactors]
                ).toString()

        beehouse_weight_by_day :

            map : ((doc)-> 
                if doc.type == "measure" and doc.beehouse_id isnt null and doc.name is "global-weight"
                    day = doc.timestamp.split("T")[0]
                    emit(day, [day,doc.value,1])

                ).toString()

            reduce : ((key,values,rereduce)-> 
                time = values[0][0]
                weights = values.map (v)-> v[1]
                factors = values.map (v)-> v[2]
                totalFactors = sum(factors)
                
                totalWeight = 0
                for weight,i in weights
                    totalWeight += weight*factors[i]
                totalWeight = totalWeight/totalFactors
                return [time,totalWeight,totalFactors]
                ).toString()

        beehouse_weight_by_quarter_day :

            map : ((doc)-> 
                if doc.type == "measure" and doc.beehouse_id isnt null and doc.name is "global-weight"
                    dayTokens = doc.timestamp.split("T")
                    day = dayTokens[0]
                    hourTokens = dayTokens[1].split(":")
                    hour = parseInt(hourTokens[0],10)
                    hour = if hour < 6 then "02" else if hour < 12 then "09" else if hour < 18 then "12" else "18"
                    quarter = day + "T" +hour+":00:00.000Z"
                    emit(quarter, [quarter,doc.value,1])

                ).toString()

            reduce : ((key,values,rereduce)-> 
                time = values[0][0]
                weights = values.map (v)-> v[1]
                factors = values.map (v)-> v[2]
                totalFactors = sum(factors)
                
                totalWeight = 0
                for weight,i in weights
                    totalWeight += weight*factors[i]
                totalWeight = totalWeight/totalFactors
                return [time,totalWeight,totalFactors]
                ).toString()

        beehouse_weight_by_week :

            map : ((doc)-> 
                if doc.type is "measure" and doc.beehouse_id isnt null and doc.name is "global-weight"
                    
                    day = new Date(doc.timestamp)
                    day.setHours(0,0,0)
                    
                    day.setDate(day.getDate() + 4 - (day.getDay()||7))
                    yearStart = new Date(day.getFullYear(),0,1)
                    weekNo = Math.ceil(( ( (day - yearStart) / 86400000) + 1)/7)

                    tag = yearStart.getFullYear() + "W" + ("0" + weekNo).slice(-2)
                                

                    #emit([doc.beehouse_id,tag], [doc.value,1])
                    emit([doc.beehouse_id,tag], [doc.value,1])

                ).toString()

            reduce : ((key,values)->

                #time = values[0][0]
                weights = values.map (v)-> v[0]
                factors = values.map (v)-> v[1]
                totalFactors = sum(factors)
                
                totalWeight = 0
                for weight,i in weights
                    totalWeight += weight*factors[i]
                totalWeight = totalWeight/totalFactors
                return [totalWeight,totalFactors]
                ).toString()