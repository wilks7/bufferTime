
//
//  Candle.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/21/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//
// http://waracle.net/iphone-nsdateformatter-date-formatting-table/

import Foundation

class Candle {
    
    
    
    var time: String = ""
    var date: NSDate = NSDate()
    
    
    init?(json: [String:AnyObject]){
        guard let title = json["title"] as? String, let date = json["date"] as? String else {return nil}
        
        let trimmed = trimDate(date)
        
        self.time = title
        self.date = dateFormatter(trimmed)
    }
    
    init(dicNS:[String:AnyObject]){
        guard let time = dicNS["time"] as? String, let date = dicNS["date"] as? NSDate else {return}
        self.time = time
        self.date = date
    }
    
    func dictionaryCopy()->[String:AnyObject]{
        return ["time":time,"date": date]
    }
    
    func trimDate(dateString: String)->String{
        
        var myString = dateString.stringByReplacingOccurrencesOfString("T", withString: " ")
        
        
        var dateArray = Array(myString.characters)
        var datee = ""
        for i in 0...18{
            datee.append(dateArray[i])
        }
        
        let dateStringR = String(datee)
        return dateStringR
    }
    
    func stringDate() -> String{
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = format.stringFromDate(self.date)
        return myString
    }
    
    func dateFormatter(date: String) -> NSDate {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myDate = format.dateFromString(date)
        return myDate!
    }
}