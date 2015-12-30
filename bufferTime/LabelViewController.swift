//
//  LabelViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/23/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

import UIKit
import MapKit

class LabelViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userDic = NSUserDefaults.standardUserDefaults().valueForKey("user") as? [String:AnyObject]
            else {print("nope");return}
    
        if let address = userDic["address"]{
            let myString = address.description
            label.text = myString
        }
    }

    

}
