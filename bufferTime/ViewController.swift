//
//  ViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/21/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleNotification:", name: "locationUpdated", object: nil)
        
        LocationController.sharedInsance.getCurrentLocation()

    }
    
    func handleNotification(notification: NSNotification) {
        if let location = notification.userInfo!["location"] as? CLLocation {
            print("Current Location: \(location)")
            
        }
        if let stringName = notification.userInfo!["stringLocation"] as? String {
            print("Current Address: \(stringName)")
        }
        
        if let zip = notification.userInfo!["zip"] as? String {
            print("Zip: \(zip)")
        }
    }
    
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