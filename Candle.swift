
//
//  Candle.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/21/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

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
    
    func dateFormatter(date: String) -> NSDate {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myDate = format.dateFromString(date)
        return myDate!
    }
}