//
//  FirstViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 1/11/16.
//  Copyright © 2016 JustWilks. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    
    
    @IBAction func chooseBufferTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("noNSuser", sender: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !(SettingsController.sharedController.checkNS()){
            self.performSegueWithIdentifier("noNSuser", sender: nil)
            print("out")
        }else{
            print("in")
        }
    }
}
