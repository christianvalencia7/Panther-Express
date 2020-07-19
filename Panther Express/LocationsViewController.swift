//
//  LocationsViewController.swift
//  Panther Express
//
//  Created by Christian Valencia on 7/19/20.
//  Copyright © 2020 PantherHacks. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    var order = Order()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        var annotation = MKPointAnnotation()
        annotation.title = "Delivery Location"
        var coordinate = CLLocationCoordinate2D(latitude: order.deliveryLatitud, longitude: order.deliveryLogitud)
        annotation.coordinate = coordinate
        
        map.addAnnotation(annotation)
        
        annotation = MKPointAnnotation()
        annotation.title = "Pickup Location"
        coordinate = CLLocationCoordinate2D(latitude: order.pickUpLatitud, longitude: order.pickUpLogitud)
        annotation.coordinate = coordinate
        
        map.addAnnotation(annotation)
        
        locationManager.stopUpdatingLocation()
        
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        map.setRegion(region, animated: true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
    }
    
        
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
