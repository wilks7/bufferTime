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
        
    @IBAction func nextTapped(sender: AnyObject) {
        let address = createAddress()
        LocationController.locationFromAddress(address) { (location, placemark) -> Void in
            
            if let location = location {
                
                let myUser = User(time: NSTimeInterval(0))
                myUser.setAddress(location)
                let dic = myUser.dictionaryCopy()
                
                NSUserDefaults.standardUserDefaults().setValue(dic, forKey: "user")
                
                self.performSegueWithIdentifier("toNext", sender: nil)
                
            }else{
                print("no found location")
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
