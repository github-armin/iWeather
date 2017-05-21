//
//  Config.swift
//  iWeather
//
//  Created by Kevin Armin Zardkoohi on 5/21/17.
//  Copyright © 2017 BDA. All rights reserved.
//

import Foundation

var BASE_URL:String = "http://api.openweathermap.org/data/2.5/weather?"
var API_KEY:String = "792695abf97df65fb1bfdc16754caa76"

typealias DownloadComplete = ()->()

func parseWeatherURL(lat:String, lng:String) -> String {
    return "\(BASE_URL)lat=\(lat)&lon=\(lng)&appid=\(API_KEY)"
}

var WEATHER_URL = "\(BASE_URL)lat=29.7604&lon=95.3698&appid=\(API_KEY)"
