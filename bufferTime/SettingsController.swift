//
//  SettingsController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 1/11/16.
//  Copyright © 2016 JustWilks. All rights reserved.
//

import UIKit

class SettingsController {

    static let sharedController = SettingsController()
    
    func checkNS()->Bool{
        
        guard let _ = NSUserDefaults.standardUserDefaults().valueForKey("allSettings") else {return false}
        return true
    }

}
