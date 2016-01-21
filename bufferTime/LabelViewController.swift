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
    
    
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var addressLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    @IBOutlet weak var resetButtonOutlet: UIButton!
    
    var zip = ""
    
    
    @IBAction func resetButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        NetworkController.fetchBasedOnZip(zip) { (holidays, candles, parshas, error) -> Void in
            if let candles = candles {
                CandleController.sharedController.allCandles = candles
                let candlesDic:[[String:AnyObject]] = candles.map({$0.dictionaryCopy()})
                NSUserDefaults.standardUserDefaults().setValue(candlesDic, forKey: "allCandles")
                print("\nCandles: \(candles.count)")
                for candle in candles {
                    print(candle.stringDate())
                }
                
            }
            if let holidays = holidays {
                print("\nHolidays: \(holidays.count)")
                for holiday in holidays {
                    print(holiday.name)
                    print(holiday.date)
                }
            }
            if let parshas = parshas {
                print("\nParshas: \(parshas.count)")
                for parsha in parshas {
                    print(parsha.date)
                    print(parsha.title)
                }
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let coordinates = NSUserDefaults.standardUserDefaults().valueForKey("addressCoordinates") as? [String : Double]{
            
            guard let longitude = coordinates["longitude"],
                let latitude = coordinates["latitude"] else {return}
            
            let location = CLLocation(latitude: latitude, longitude: longitude)
            
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            
            let anotation = Home(title: "Home", coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), info: "Spend Shabbos")
            
            self.map.setRegion(region, animated: true)
            self.map.addAnnotation(anotation)
        }
        
        if let address = NSUserDefaults.standardUserDefaults().valueForKey("addressString") as? String {
            self.addressLabel.text = address
        }
        
        if let zip = NSUserDefaults.standardUserDefaults().valueForKey("homeZip") as? String {
            self.zip = zip
        }
        
        if let buffer = NSUserDefaults.standardUserDefaults().valueForKey("bufferTime"){
            
            if let buffer = buffer as? Int{
                let totalMinutes = buffer/60
                let hours = totalMinutes/60
                let minutes = totalMinutes%60
                self.timeLabel.text = String(hours)+" hours and "+String(minutes)+" minutes"
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    func setupButtons(){
        self.map.layer.borderWidth = 1
        self.map.layer.borderColor = UIColor.whiteColor().CGColor
        self.map.layer.cornerRadius = 5
        
        saveButtonOutlet.layer.borderWidth = 1
        saveButtonOutlet.layer.borderColor = UIColor.whiteColor().CGColor
        saveButtonOutlet.layer.cornerRadius = 5
        
        resetButtonOutlet.layer.borderWidth = 1
        resetButtonOutlet.layer.borderColor = UIColor.whiteColor().CGColor
        resetButtonOutlet.layer.cornerRadius = 5
    }

}
