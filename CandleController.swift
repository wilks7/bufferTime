//
//  CandleController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/22/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

import Foundation
import UIKit

class CandleController {
    
    static let sharedController = CandleController()
    
    var allCandles:[Candle] = []
    
    var todayCandle: NSDate?
    
    func setNotification(fireDate: NSDate) {
        let alarmNotification = UILocalNotification()
        alarmNotification.userInfo!["test"] = "Testing"
        alarmNotification.fireDate = fireDate
        alarmNotification.timeZone = NSTimeZone.localTimeZone()
        alarmNotification.soundName = "sms-received3.caf"
        alarmNotification.alertBody = "Alarm Complete!"
        
        UIApplication.sharedApplication().scheduleLocalNotification(alarmNotification)
    }
    
    func set30minIntervals(candleTime: NSDate){
                
        var tempDate = candleTime
        for _ in 0...10{
            let newDate = tempDate.dateByAddingTimeInterval(-1800)
            tempDate = newDate
            
            let silentAlert = UILocalNotification()
            silentAlert.fireDate = newDate
            silentAlert.userInfo = ["silent" : true]
            silentAlert.timeZone = NSTimeZone.localTimeZone()
            UIApplication.sharedApplication().scheduleLocalNotification(silentAlert)
            NSNotificationCenter.defaultCenter().postNotificationName("updateInterval", object: nil, userInfo: ["NStest":"thisIsTest"])

        }
    }
    
    func setTimer(){
        var timer = NSTimer()
        timer = NSTimer.scheduledTimerWithTimeInterval(10, target:self, selector: Selector("intervalUpdate"), userInfo: nil, repeats: true)
    }
    
}