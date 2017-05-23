//
//  WeatherCell.swift
//  iWeather
//
//  Created by Kevin Armin Zardkoohi on 5/22/17.
//  Copyright © 2017 BDA. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIconImg: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forecast: Forecast) {
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        weatherType.text = forecast.weatherType
        dayLbl.text = forecast.date
        weatherIconImg.image = UIImage(named: "\(forecast.weatherType) Mini")
    }

}
