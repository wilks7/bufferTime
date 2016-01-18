//
//  Home.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 1/17/16.
//  Copyright © 2016 JustWilks. All rights reserved.
//

import MapKit
import UIKit

class Home: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}