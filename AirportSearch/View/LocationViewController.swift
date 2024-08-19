//
//  LocationViewController.swift
//  AirportSearch
//
//  Created by Porfirio on 17/08/24.
//

import UIKit
import MapKit
import CoreLocation
class LocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           if let location = locations.last {
               
               let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
               let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
               mapView.setRegion(region, animated: true)
           }
       }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Error obteniendo la ubicación: \(error.localizedDescription)")
       }

   

}
