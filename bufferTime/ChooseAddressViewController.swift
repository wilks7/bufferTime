//
//  ChooseAddressViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/23/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

import UIKit
import MapKit

class ChooseAddressViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var firstUser = false
    
    @IBOutlet weak var addressTextfield: UITextField!
    
    @IBOutlet weak var zipTextfield: UITextField!
    
    @IBOutlet weak var hourPicker: UIPickerView!

    @IBOutlet weak var minutePicker: UIPickerView!
    
    @IBAction func nextTapped(sender: AnyObject) {
        
        let bufferTime = self.pickerToTime()
        NSUserDefaults.standardUserDefaults().setValue(bufferTime, forKey: "bufferTime")
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "allSettings")
        
        let address = createAddress()
        
        LocationController.locationFromAddress(address) { (location, placemark) -> Void in
            
            if let location = location {
                
                LocationController.sharedInsance.addressFromLocation(location, completion: { (stringLocation, zip) -> Void in
                    NSUserDefaults.standardUserDefaults().setValue(stringLocation, forKey: "addressString")
                    NSUserDefaults.standardUserDefaults().setValue(zip, forKey: "homeZip")
                    
                    let coord = location.coordinates
                    
                    NSUserDefaults.standardUserDefaults().setValue(coord, forKey: "addressCoordinates")
                    
                    if self.firstUser{
                        self.firstUser = false
                        self.performSegueWithIdentifier("correct", sender: nil)
                    } else {
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                    }
                })
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
    

    
    func pickerToTime()->NSTimeInterval{
        let hours = hourPicker.selectedRowInComponent(0)
        let totalMinutes = minutePicker.selectedRowInComponent(0) + (hours * 60)
        let totalSeconds = NSTimeInterval(totalMinutes * 60)
        
        return totalSeconds
    }
    
    // MARK: - Picker Datasource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == hourPicker{
            return 12
        }else{
            return 60
        }
    }
    
    // MARK: - Picker Delegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    // MARK: TextField Delegate 
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        addressTextfield.resignFirstResponder()
        zipTextfield.resignFirstResponder()
    }
    
}
