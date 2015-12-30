//
//  UserController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/23/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

import Foundation
import MapKit

class UserController{
    
    let keyForNS = "currentUser"
    
    static let sharedController = UserController()
    
    var currentUser: User!
        {
        get{
            guard let userDic = NSUserDefaults.standardUserDefaults().valueForKey(keyForNS) as? [String:AnyObject] else {return nil}
            return User(dic: userDic)
        }
        
        set {
            if let newValue = newValue {
                NSUserDefaults.standardUserDefaults().setValue(newValue.dictionaryCopy(), forKey: keyForNS)
                NSUserDefaults.standardUserDefaults().synchronize()
            }else{
                NSUserDefaults.standardUserDefaults().removeObjectForKey(keyForNS)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    func setAddress(loc: CLLocation){
        UserController.sharedController.currentUser.address = loc
        currentUser.address = loc
        
        print(loc)
        
        UserController.sharedController.currentUser.setAddress(loc)
        
        print(UserController.sharedController.currentUser.address)
    }
    
    static func setBufferTime(interval: NSTimeInterval){
        UserController.sharedController.currentUser.bufferTime = interval
    }
    
}