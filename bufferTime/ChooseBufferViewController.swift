//
//  ChooseBufferViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/22/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

import UIKit

class ChooseBufferViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var minutePicker: UIPickerView!
    @IBOutlet weak var hourPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func nextButtonTapped(sender: AnyObject) {
        let bufferTime = pickerToTime()
        let user = User(time: bufferTime)
        let userDic = user.dictionaryCopy()
        
        NSUserDefaults.standardUserDefaults().setValue(userDic, forKey: "userDictionary")
        NSUserDefaults.standardUserDefaults().setValue(bufferTime, forKey: "bufferTime")
        
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

}
