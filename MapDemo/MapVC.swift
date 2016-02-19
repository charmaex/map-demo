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

}

