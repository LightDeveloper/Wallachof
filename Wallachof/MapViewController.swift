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
import SwiftyButton


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
    
    func addChuchelandia() {
        let coord = CLLocationCoordinate2D(latitude: 40.292596, longitude: -3.745971)
        let poi = PointOfInterest(title: "Chuchelandia",
                                  subtitle: "Se te hace el chuche agua",
                                  coordinate: coord)

        mapProduct.addAnnotation(poi)
    }
    
    func centerMapOnLocation(_ location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 200.0, longitudinalMeters: 200.0)
        mapProduct.setRegion(region, animated: true)
    }
    
    @IBAction func btnCargaPressed(_ sender: PressableButton) {
        sender.colors = .init(button: .cyan, shadow: .blue)
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
        addChuchelandia()
    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        debugPrint("didFailToLocateUserWithError")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        debugPrint("Annotation \(type(of: annotation))")
        
        guard let annotation = annotation as? PointOfInterest else {
            return nil
        }
        let identifier = "poiId"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.image = UIImage(named: "drogoncito")
            view.canShowCallout = true
            
//            view.calloutOffset = CGPoint(x: -50, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
}
