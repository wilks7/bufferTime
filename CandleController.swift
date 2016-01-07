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
        alarmNotification.fireDate = fireDate
        alarmNotification.timeZone = NSTimeZone.localTimeZone()
        alarmNotification.soundName = "sms-received3.caf"
        alarmNotification.alertBody = "Alarm Complete!"
        
        UIApplication.sharedApplication().scheduleLocalNotification(alarmNotification)
    }
}