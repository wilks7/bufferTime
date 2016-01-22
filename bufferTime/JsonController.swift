//
//  JsonController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 1/21/16.
//  Copyright © 2016 JustWilks. All rights reserved.
//

import Foundation

class JsonController {
    
    static func queryHolidays()-> Holiday? {
        
        guard let path = NSBundle.mainBundle().pathForResource("Holiday_JSON_2016", ofType: "json") else {return nil}
        
        guard let json = NSData(contentsOfFile: path) else {return nil}
        
        let object: AnyObject
        
        do {
            object = try NSJSONSerialization.JSONObjectWithData(json, options: [])
        } catch {
            print("Json failed")
            return nil
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayString = formatter.stringFromDate(NSDate())
        
        if let dicObject = object as? [String:AnyObject]{
            if let itemsArray = dicObject["items"] as? [[String:AnyObject]]{
                
                for dic in itemsArray {
                    let holiday = Holiday(json: dic)
                    
                    if let myHoliday = holiday {
                        if todayString == myHoliday.date {
                            return myHoliday
                        }
                    }
                }
            }
        }
        return nil
    }
    
    
    
    static func queryParshas()->Parsha?{
        
        guard let path = NSBundle.mainBundle().pathForResource("Holiday_JSON_2016", ofType: "json") else {return nil}
        
        guard let json = NSData(contentsOfFile: path) else {return nil}
        
        let object: AnyObject
        
        do {
            object = try NSJSONSerialization.JSONObjectWithData(json, options: [])
        } catch {
            print("Json failed")
            return nil
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayString = formatter.stringFromDate(NSDate())
        
        if let dicObject = object as? [String:AnyObject]{
            
        }
        
        
        return nil
    }
    
}

