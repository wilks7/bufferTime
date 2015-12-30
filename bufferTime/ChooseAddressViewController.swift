//
//  ChooseAddressViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/23/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

import UIKit
import MapKit

class ChooseAddressViewController: UIViewController {

    @IBOutlet weak var addressTextfield: UITextField!
    
    @IBOutlet weak var zipTextfield: UITextField!
    
    @IBOutlet weak var stateTextfield: UITextField!
    
    @IBAction func nextTapped(sender: AnyObject) {
        LocationController.locationFromAddress(createAddress()) { (location) -> Void in
            if let location = location {
                let myUser = User(time: NSTimeInterval(0))
                myUser.setAddress(location)
                let dic = myUser.dictionaryCopy()
                
                NSUserDefaults.standardUserDefaults().setValue(dic, forKey: "user")
                
                //UserController.sharedController.setAddress(placemark)
                
            }else{
                print("none")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func createAddress()->String{
        
        let first = addressTextfield.text! + ", "
        let second = zipTextfield.text!
        return first + second
    }
    
    
    

}
