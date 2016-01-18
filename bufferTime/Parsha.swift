//
//  Parsha.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 1/17/16.
//  Copyright © 2016 JustWilks. All rights reserved.
//

import Foundation
import UIKit

class Parsha {
    
    var hebrew: String
    var title: String
    var date: String
    
    init(json: [String:AnyObject]){
        guard let hebrew = json["hebrew"] as? String, let title = json["title"] as? String, let date = json["date"] as? String else {self.hebrew = ""; self.date = ""; self.title = ""; return}
        
        self.hebrew = hebrew
        self.title = title
        self.date = date
    }
    
}