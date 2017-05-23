//
//  WeatherVC.swift
//  iWeather
//
//  Created by Kevin Armin Zardkoohi on 5/19/17.
//  Copyright © 2017 BDA. All rights reserved.
//

import UIKit
import Alamofire
import EasyAnimation
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    
    @IBOutlet weak var todayDateLbl:UILabel!
    
    @IBOutlet weak var currentTempLbl: UILabel!
    
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var currentWeatherLbl: UILabel!
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    //Launchscreen Outlets
    @IBOutlet weak var launchScreenImage: UIImageView!
    @IBOutlet weak var launchScreenLbl: UILabel!
    @IBOutlet weak var launchScreenBG: UIView!
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    
    var currentWeather:CurrentWeather!
    var forecast:Forecast!
    var forecasts = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        //forecast = Forecast()
        currentWeather = CurrentWeather()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.lat = currentLocation.coordinate.latitude
            Location.sharedInstance.lng = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        self.launchScreenBG.alpha = 0
                    })
                    
                }
                
            }
            print(Location.sharedInstance.lat, Location.sharedInstance.lng)
        }
        else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: parseForecastURL(lat: "\(Location.sharedInstance.lat!)", lng: "\(Location.sharedInstance.lng!)"))
        Alamofire.request(forecastURL!).responseJSON {
            response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    //print("Number of forecasts \(self.forecasts.count)")
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }
        else {
            return WeatherCell()
        }
    }

    func updateMainUI() {
        todayDateLbl.text = currentWeather.date
        currentTempLbl.text = "\(Int(currentWeather.currentTemp))°"
        currentWeatherLbl.text = "(\(currentWeather.weatherType))"
        locationLbl.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }

}

