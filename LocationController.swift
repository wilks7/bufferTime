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
    
    static let sharedController = LocationController()
    var locationManager = CLLocationManager()
    var currentLocationCoord: [String : Double]?
    var hasLocation = false
    var trafficTime : Int?
    
    
    func getTrafficTime(completion:(time: Int?, error: NSError?)->Void) {
        
        guard let destination = NSUserDefaults.standardUserDefaults().valueForKey("addressCoordinates") as? [String : Double] else { completion(time: nil, error: nil);
            return }
        
        if let origin = currentLocationCoord{
            NetworkController.googleMapsDirections(origin, destination: destination) { (time, trafficTime, error) -> Void in
                if let time = time {
                    self.timeToLeave(time)
                    completion(time: time, error: nil)
                }
            }
        } else {
            print("couldnt get current location")
        }
    }
    
    func timeToLeave(travelTime: Int) {
        let shabbosTime: NSDate? = NSDate().dateByAddingTimeInterval(28800)
        guard let prepTime = NSUserDefaults.standardUserDefaults().valueForKey("bufferTime") as? NSTimeInterval else { return }
        let arrivalTime = shabbosTime?.dateByAddingTimeInterval(prepTime*(-1))
        let myTravelTime: NSTimeInterval = NSTimeInterval(Int(travelTime))
        let departureTime = arrivalTime?.dateByAddingTimeInterval(myTravelTime*(-1))
        let currentTime = NSDate()
        
        let timeInt = Int(departureTime!.timeIntervalSinceDate(currentTime))
        let timeLeft: NSTimeInterval = NSTimeInterval(Int(timeInt))
        if timeLeft.advancedBy(1800) > myTravelTime {
            print("You should leave by \(departureTime)")
        }
    }
    
    
    //MARK: - CoreLocation Delegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("location found")
            
        if !hasLocation {
            hasLocation = true
            if let foundLocation = locations.first{
                
                currentLocationCoord = foundLocation.coordinates
                getTrafficTime({ (time, error) -> Void in
                    if let time = time {
                        self.trafficTime = time
                        self.timeToLeave(time)
                    }
                })
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
        print("Cant Get Current Locaiton")
    }
    
    
    // MARK: - String Work
    func addressFromLocation(location: CLLocation, completion:(stringLocation: String, zip: String)->Void){
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) -> Void in
            guard let placemarks = placemarks else {return completion(stringLocation: "Unknown", zip: "Unkown")}
            
            if let nameOfLocation = placemarks.first?.name, let zip = placemarks.first?.postalCode, let city = placemarks.first?.locality {
                let string = "\(nameOfLocation), \(city), \(zip)"
                completion(stringLocation: string, zip: zip)
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
}



extension CLLocation {
    var coordinates: [String:Double] {
        
        var coord = [String : Double]()
        let lat = self.coordinate.latitude
        let lon = self.coordinate.longitude
        coord["latitude"] = lat
        coord["longitude"] = lon
        
        return coord
    }
}
