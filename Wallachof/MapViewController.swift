//
//  MapViewController.swift
//  Wallachof
//
//  Created by Dev2 on 22/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    let locationManager = CLLocationManager()

    @IBOutlet weak var mapProduct: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapProduct.showsUserLocation = true
        mapProduct.delegate = self
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation(_ location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 400.0, longitudinalMeters: 400.0)
        mapProduct.setRegion(region, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView){
        debugPrint("mapViewWillStartLocatingUser")
    }
    
    func mapViewDidStopLocatingUser(_ mapView: MKMapView) {
        debugPrint("mapViewDidStopLocatingUser")
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        debugPrint("didUpdate \(userLocation.coordinate)")
        centerMapOnLocation(userLocation.coordinate)
    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        debugPrint("didFailToLocateUserWithError")
    }
    
}
