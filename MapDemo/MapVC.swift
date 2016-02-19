//
//  ViewController.swift
//  MapDemo
//
//  Created by Jan Dammshäuser on 18.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!

    let locationManager = CLLocationManager()
    
    let regionRadius: CLLocationDistance = 1_000_000

    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newAnnotations:", name: "newAnnotations", object: nil)
        
        Addresses.inst.getAddresses()
    }

    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        guard let loc = userLocation.location else {
            return
        }
        
        centerMap(onLocation: loc)
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKindOfClass(MKUserLocation) else {
            return nil
        }
        
        if annotation.isKindOfClass(HotelAnnotations) {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annotationView.pinTintColor = UIColor.blueColor()
            annotationView.animatesDrop = true
            
            return annotationView
        }
        
        return nil
    }
    
    func locationAuthStatus() {
        
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            map.showsUserLocation = true
        case .NotDetermined:
            locationAuthStatus()
        default:
            break
        }
        
    }
    
    func centerMap(onLocation loc: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(loc.coordinate, regionRadius, regionRadius)
        
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func newAnnotations(notif: AnyObject) {
        for annotation in GeoCoder.inst.annotations {
            map.addAnnotation(annotation)
        }
    }

}
