//
//  HotelAnnotations.swift
//  MapDemo
//
//  Created by Jan Dammshäuser on 19.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation
import MapKit

class HotelAnnotations: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
}
