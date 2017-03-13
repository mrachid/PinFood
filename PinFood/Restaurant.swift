//
//  Restaurant.swift
//  PinFood
//
//  Created by Mahmoud RACHID on 24/02/2017.
//  Copyright © 2017 Mahmoud RACHID. All rights reserved.
//

import Foundation


class Restaurant {
    
    var type = ""
    var name = ""
    var location = ""
    var image = ""
    var isVisited = false
    var phone = ""
    var rating = ""
    
    init(name: String, type: String, location: String, phone : String, image: String, isVisited: Bool) {
        
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
        self.phone = phone
    }
}
