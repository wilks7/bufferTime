//
//  User.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/23/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

import Foundation
import MapKit

class User{
    
    var bufferTime = NSTimeInterval(1)
    var address = CLLocation()
    
    init(time: NSTimeInterval){
        
        self.bufferTime = time
        
    }
    
    init?(dic: [String:AnyObject]){
        guard let time = dic["time"] as? NSTimeInterval else {return nil}
        self.bufferTime = time
        if let addressDic = dic["address"]{
            let lon = addressDic["lon"] as? Double
            let lat = addressDic["lat"] as? Double
            let loc = CLLocation(latitude: lat!, longitude: lon!)
            self.address = loc
        }
    }
    
    func dictionaryCopy()->[String:AnyObject]{
        var pointDic = [String:AnyObject]()
        let lon = address.coordinate.longitude
        let lat = address.coordinate.latitude
        pointDic["lat"] = lat
        pointDic["lon"] = lon
        return ["time":bufferTime,
            "address": pointDic
        ]
    }
    
    func setAddress(loc: CLLocation){
        self.address = loc
        print("")
    }
    
}