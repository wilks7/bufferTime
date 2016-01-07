//
//  NetworkController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/21/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

import Foundation

class NetworkController {
    
    static let urlString = "http://www.hebcal.com/hebcal/?v=1&cfg=json&maj=on&min=off&year=2016&month=x&c=onm=0&geo=geoname&geonameid=3448439&m=50&s=on"
    
    
    static func fetchBasedOnZip(zip: String, completion:(holidays: [Holiday]?, candles: [Candle]?, error: NSError? )->Void){
        
        let myUrlString = "http://www.hebcal.com/hebcal/?v=1&cfg=json&maj=on&min=off&year=2016&month=x&c=onm=0&geo=zip&zip=\(zip)&m=0&s=on"
        
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
                    }
                }
                completion(holidays: holidays, candles: candleLightings, error: nil)
            } else {
                completion(holidays: nil, candles: nil, error: nil)
            }
            
        }
        dataTask.resume()
        
    }
    
    static func fetchHolidays(completion:(holidays: [Holiday]?, candles: [Candle]?, error: NSError? )->Void){
        
        guard let url = NSURL(string: urlString) else {print("url problem");return}

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
    
}