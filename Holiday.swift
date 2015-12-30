//
//  Holiday.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/21/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

import Foundation

class Holiday {
    
    var name: String = ""
    var yomtov = false
    var hebrew: String = ""
    var date: String = ""
    
//    init(name: String){
//        self.name = name
//    }
    
    init?(json: [String:AnyObject]){
        guard let name = json["title"] as? String,
                let hebrew = json["hebrew"] as? String,
                let date = json["date"] as? String
            else {return nil}
        self.name = name
        self.date = date
        self.hebrew = hebrew
    }
   
}