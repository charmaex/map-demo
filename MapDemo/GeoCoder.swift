//
//  File.swift
//  MapDemo
//
//  Created by Jan Dammshäuser on 19.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation
import MapKit

class GeoCoder {
    static let inst = GeoCoder()
    
    private var _annotations = [HotelAnnotations]()
    
    var annotations: [HotelAnnotations] {
        return _annotations
    }
    
    func getAnnotationForAddresses(addresses: [String]) {
        _annotations.removeAll()

        for address in addresses {
            getLocation(address)
        }
    }

    private func getLocation(address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            guard let marks = placemarks where marks.count > 0 else {
                return
            }
            guard let loc = marks[0].location else {
                return
            }

            self.makeAnnotation(loc)
        }
    }

    private func makeAnnotation(loc: CLLocation) {
        let annotation = HotelAnnotations(coordinate: loc.coordinate)
        
        _annotations.append(annotation)
        
        NSNotificationCenter.defaultCenter().postNotificationName("newAnnotations", object: nil)
    }
}