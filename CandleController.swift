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
    
    let bufferTime = ""
    
    func setNotification(fireDate: NSDate) {
        let alarmNotification = UILocalNotification()
        alarmNotification.userInfo!["test"] = "Testing"
        alarmNotification.fireDate = fireDate
        alarmNotification.timeZone = NSTimeZone.localTimeZone()
        alarmNotification.soundName = "sms-received3.caf"
        alarmNotification.alertBody = "Alarm Complete!"
        
        UIApplication.sharedApplication().scheduleLocalNotification(alarmNotification)
    }
    
    func setUpdateLocationNotifiers(firedate: NSDate){
                
        var tempDate = firedate
        for _ in 0...10{
            let newDate = tempDate.dateByAddingTimeInterval(-1800)
            tempDate = newDate
            
            let silentAlert = UILocalNotification()
            silentAlert.fireDate = newDate
            silentAlert.userInfo = ["silent" : true]
            silentAlert.timeZone = NSTimeZone.localTimeZone()
            UIApplication.sharedApplication().scheduleLocalNotification(silentAlert)
        }
    }
    
}