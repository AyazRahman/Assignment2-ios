//
//  Data.swift
//  Assignment2
//
//  Created by Ayaz Rahman on 28/9/19.
//  Copyright © 2019 M Rahman. All rights reserved.
//

import Foundation

//struct WeatherCondition {
//    var date: Date
//    var condition: String
//}

class Data {
    static var sensorReadings = [SensorReading]()
    static var currentReading = SensorReading()
//    static var weatherCondition = WeatherCondition(date: Date(), condition: "NIL")
    
    static func get3days(sensor: String) -> [String]{
        if sensorReadings.count == 0{return ["NA", "NA"]}
        
        let threeHour = sensorReadings.filter({ (item) -> Bool in
            return item.timestamp.timeIntervalSinceNow > -86400
        })
        let threeDays = sensorReadings.filter({ (item) -> Bool in
            return item.timestamp.timeIntervalSinceNow > -259200
        })
        
        var sum3hours: Double, sum3days: Double
        
        switch sensor {
        case "Temperature":
            sum3hours = threeHour.reduce(0){$0 + $1.temperature}
            sum3days = threeDays.reduce(0){$0 + $1.temperature}
            
        case "Pressure":
            sum3hours = threeHour.reduce(0){$0 + $1.pressure} / 1000
            sum3days = threeDays.reduce(0){$0 + $1.pressure} / 1000
            
        case "Altitude":
            sum3hours = threeHour.reduce(0){$0 + $1.altitude}
            sum3days = threeDays.reduce(0){$0 + $1.altitude}
        default:
            return ["NA", "NA"]
        }
        
        let average3hours = Int(sum3hours) / (threeHour.count == 0 ? 1 : threeHour.count)
        let average3days = Int(sum3days) / (threeDays.count == 0 ? 1 : threeDays.count)
        return [(average3hours == 0 ? "NA" : String(average3hours)), (average3days == 0 ? "NA" : String(average3days))]
    }
    
//    static func getWeatherCondition(lat: String, lon: String) -> String{
//        if weatherCondition.date.timeIntervalSinceNow > -600 || weatherCondition.condition == "NIL"{
//            // send the request
//            let requestURL = "api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=f33af4818b00edb5ea80caba5310db66"
//            let jsonURL = URL(string: requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
//            let task = URLSession.shared.dataTask(with: jsonURL!){
//                (data, response, error) in
//                if let error = error{
//                    print(error.localizedDescription)
//                    return
//                }
//                if let values = data {
//                    let jsonRoot = try? JSONSerialization.jsonObject(with: values, options: [])
//                    if let dictionary = jsonRoot as? [String: Any]{
//                        let list = dictionary["list"] as? [String: Any]
//                        for var i in 0..<3{
//                            if let item = list?[i]{
//
//                            }
//
//                        }
//                    }
//                }
//            }
//            return ""
//        }
//        return weatherCondition.condition
//    }
}
