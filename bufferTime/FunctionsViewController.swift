//
//  FunctionsViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 1/15/16.
//  Copyright © 2016 JustWilks. All rights reserved.
//

import UIKit

class FunctionsViewController {

    func checkIfCandleDay(){
        
        let candleDates = String()
        
        if getDayOfWeek() == 6 || candleDates.containsString(dateFormat()) {
            
            
            //LocationController.sharedInsance.getCurrentLocation()
            print("Today is a candle day, getting location")
        }
    }
    
    func dateFormat()->String{
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        let dateString = formatter.stringFromDate(NSDate())
        return dateString
    }
    
    func getDayOfWeek()->Int {
        let todayDate = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let myComponents = myCalendar?.components(.Weekday, fromDate: todayDate)
        let weekDay = myComponents?.weekday
        return weekDay!
    }

}
