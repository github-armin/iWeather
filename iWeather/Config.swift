//
//  Config.swift
//  iWeather
//
//  Created by Kevin Armin Zardkoohi on 5/21/17.
//  Copyright © 2017 BDA. All rights reserved.
//

import Foundation

var BASE_URL:String = "http://api.openweathermap.org/data/2.5/weather?"
var FORECAST_URL:String = "http://api.openweathermap.org/data/2.5/forecast/daily?"
var FORECAST_COUNT = 10
var API_KEY:String = "792695abf97df65fb1bfdc16754caa76"

typealias DownloadComplete = ()->()

func parseWeatherURL(lat:String, lng:String) -> String {
    print("CurrentWeatherURL: \(BASE_URL)lat=\(lat)&lon=\(lng)&appid=\(API_KEY)")
    return "\(BASE_URL)lat=\(lat)&lon=\(lng)&appid=\(API_KEY)"
}

func parseForecastURL(lat:String, lng:String) -> String {
    print("ForecastWeatherURL: \(FORECAST_URL)lat=\(lat)&lon=\(lng)&cnt=\(FORECAST_COUNT)&appid=\(API_KEY)")
    return "\(FORECAST_URL)lat=\(lat)&lon=\(lng)&cnt=\(FORECAST_COUNT)&appid=\(API_KEY)"
}
