//
//  NetworkController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/21/15.
//  Copyright © 2015 JustWilks. All rights reserved.
// google api key : AIzaSyDl4d4R3YjYHbKcZIemBEYMs1ujGrG2ekY

import Foundation

class NetworkController {
    
    static let urlString = "http://www.hebcal.com/hebcal/?v=1&cfg=json&maj=on&min=on$mod=on&year=2016&month=x&c=onm=0&geo=geoname&geonameid=3448439&m=50&s=on"
    
    static let googleMapsAPI = "https://maps.googleapis.com/maps/api/directions/json?origin=&destination=&key=AIzaSyDl4d4R3YjYHbKcZIemBEYMs1ujGrG2ekY"
    
    
    static func fetchBasedOnZip(zip: String, completion:(holidays: [Holiday]?, candles: [Candle]?, parshas: [Parsha]?, error: NSError? )->Void){
        
        let myUrlString = "http://www.hebcal.com/hebcal/?v=1&cfg=json&maj=on&min=on$mod=on&year=2016&month=x&c=onm=0&geo=zip&zip=\(zip)&m=0&s=on"
        
        guard let url = NSURL(string: myUrlString) else {print("url problem");return}
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let error = error {
                completion(holidays: nil,candles: nil, parshas: nil, error: error)
            }
            
            guard let data = data else { completion(holidays: nil, candles: nil, parshas: nil, error: nil); return }
            
            let jsonObject: AnyObject
            
            do {
                jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            } catch (let error as NSError){
                completion(holidays: nil, candles: nil, parshas: nil, error: error)
                return
            }
            
            var candleLightings = [Candle]()
            var holidays = [Holiday]()
            var parshas = [Parsha]()
            
            //guard let jsonData = jsonObject as? [String:AnyObject] else {return}
            if let items = jsonObject["items"] as? [[String:AnyObject]]{
                print(items.count)
                for i in 0...items.count - 1{
                    let item = items[i]
                    if let category = item["category"] as? String{
                        if category == "candles"{
                            let light = Candle(json: item)
                            candleLightings.append(light!)
                        }
                        else if category == "holiday"{
                            if let holiday = Holiday(json: item){
                                holidays.append(holiday)
                            }
                        }
                        else if category == "parashat" {
                            let parsha = Parsha(json: item)
                            parshas.append(parsha)
                            
                        }
                    }
                }
                completion(holidays: holidays, candles: candleLightings, parshas: parshas, error: nil)
            } else {
                completion(holidays: nil, candles: nil, parshas: nil, error: nil)
            }
            
        }
        dataTask.resume()
    }
    
    static func fetchHolidays(completion:(holidays: [Holiday]?, candles: [Candle]?, error: NSError? )->Void){
        
        let myUrlString = "http://www.hebcal.com/hebcal/?v=1&cfg=json&maj=on&min=on%mod=on&year=2016&month=x"
        
        guard let url = NSURL(string: myUrlString) else {print("url problem");return}

        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
         
            if let error = error {
                completion(holidays: nil,candles: nil, error: error)
            }
            
            guard let data = data else { completion(holidays: nil, candles: nil,error: nil); return }
            
            let jsonObject: AnyObject
            
            do {
                jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            } catch (let error as NSError){
                completion(holidays: nil, candles: nil, error: error)
                return
            }
            
            var candleLightings = [Candle]()
            var holidays = [Holiday]()
            
            //guard let jsonData = jsonObject as? [String:AnyObject] else {return}
            if let items = jsonObject["items"] as? [[String:AnyObject]]{
                for i in 0...items.count - 1{
                        let item = items[i]
                        if let category = item["category"] as? String{
                            if category == "candles"{
                                let light = Candle(json: item)
                                candleLightings.append(light!)
                            }
                            else if category == "holiday"{
                                if let holiday = Holiday(json: item){
                                    holidays.append(holiday)
                                }
                            }
                        }
                }
                completion(holidays: holidays, candles: candleLightings, error: nil)
            } else {
                completion(holidays: nil, candles: nil, error: nil)
            }
            
        }
        dataTask.resume()
    }
    
    static func googleMapsDirections(origin: [String:Double], destination: [String:Double], completion:(time: Int?, trafficTime: Int?, error: NSError?)->Void){
        
        var originCoord = ""
        if let lat = origin["latitude"], let lon = origin["longitude"]{
            let stringLat = String(lat)
            let stringLon = String(lon)
            
            originCoord = stringLat+","+stringLon
        }
        
        var destinationCoord = ""
        if let lat = destination["latitude"], let lon = destination["longitude"]{
            let stringLat = String(lat)
            let stringLon = String(lon)
            
            destinationCoord = stringLat+","+stringLon
        }
        
        let googleMapsAPI = "https://maps.googleapis.com/maps/api/directions/json?origin=\(originCoord)&destination=\(destinationCoord)&key=AIzaSyDl4d4R3YjYHbKcZIemBEYMs1ujGrG2ekY"
        //let googleMapsAPI = "https://maps.googleapis.com/maps/api/directions/json?origin=40.645797,-73.730383&destination=40.725797,-73.817739&departure_time=now&mode=driving&traffic_model=best_guess&key=AIzaSyDl4d4R3YjYHbKcZIemBEYMs1ujGrG2ekY"
        
        
        guard let url = NSURL(string: googleMapsAPI) else {return}
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let error = error {
                completion(time: nil, trafficTime: nil, error: error)
            }
            
            guard let data = data else {completion(time: nil, trafficTime: nil ,error: nil); return}
            
            let jsonObject: AnyObject
            
            do {
                jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            } catch (let error as NSError){
                completion(time: nil, trafficTime: nil, error: error)
                return
            }
            
            if let routes = jsonObject["routes"] as? [AnyObject]{
                if let routeData = routes.first as? [String:AnyObject]{
                    if let legs = routeData["legs"] as? [AnyObject]{
                        if let legsData = legs.first as? [String:AnyObject]{
                            var totalDuration = 0
                            var totalDurationTraffic = 0
                            if let duration = legsData["duration"] as? [String:AnyObject]{
                                if let time = duration["value"] as? Int{
                                    totalDuration = time
                                }
                            }
                            if let durationTraffic = legsData["duration_in_traffic"] as? [String:AnyObject]{
                                if let time = durationTraffic["value"] as? Int{
                                    totalDurationTraffic = time
                                }
                            }
                            completion(time: totalDuration, trafficTime: totalDurationTraffic, error: nil)
                        }
                    }
                    
                }
            }
            
        }
        dataTask.resume()
    }
    
}