//
//  Location.swift
//  iWeather
//
//  Created by Kevin Armin Zardkoohi on 5/23/17.
//  Copyright © 2017 BDA. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {
        
    }
    var lat:Double!
    var lng:Double!
    
    
}
