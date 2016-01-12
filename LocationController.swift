//
//  LocationController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/21/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class LocationController: NSObject, CLLocationManagerDelegate {
    
    static let sharedInsance = LocationController()
    private var locationManager  = CLLocationManager()
    
    func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    
    // MARK: - String Work
    func addressFromLocation(location: CLLocation, completion:(stringLocation: String, zip: String)->Void){
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) -> Void in
            guard let placemarks = placemarks else {return completion(stringLocation: "Unknown", zip: "Unkown")}
            
            if let nameOfLocation = placemarks.first?.name, let zip = placemarks.first?.postalCode {
                completion(stringLocation: nameOfLocation, zip: zip)
            } else {
                completion(stringLocation: "Unknown", zip: "Unkown")
            }
        }
    }
    
    
    static func locationFromAddress(address: String,completion:(location:CLLocation?, placemark: CLPlacemark?)->Void){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) -> Void in
            
            guard let placemarks = placemarks else {return completion(location: nil, placemark: nil) }
            let placemark = placemarks[0]
            let loc = placemark.location
            
            completion(location: loc, placemark: placemark)
        }
    }
    
    
    //MARK: - CoreLocation Delegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("location found")
        
        if let foundLocation = locations.first{
            
            addressFromLocation(foundLocation, completion: { (stringLocation, zip) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("locationUpdated", object: nil, userInfo: ["location":foundLocation, "stringLocation":stringLocation, "zip":zip])
            })
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
        print("Cant Get Current Locaiton")
    }
}

