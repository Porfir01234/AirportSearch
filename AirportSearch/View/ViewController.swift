//
//  ViewController.swift
//  AirportSearch
//
//  Created by Porfirio on 17/08/24.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    let locationManager = CLLocationManager()
    var km = ""
    var latitude = ""
    var longitude = ""
    var userService = UserService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonStyle(button: searchButton)
        kmLabel.text = "0"
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            latitude = String(lat)
            longitude = String(lon)
           // print(lat)
           // print(lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    func setupButtonStyle(button: UIButton) {
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline).withSize(18.0)
        
    }
    
    @IBAction func slidarKm(_ sender: UISlider) {
        
        let kmInt = Int(sender.value)
        km = String(kmInt)
        kmLabel.text = String(km)
          
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        
        userService.ddsss(km: km, latitud: latitude, longitud: longitude)
       
    }
    


}

