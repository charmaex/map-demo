//
//  Adresses.swift
//  MapDemo
//
//  Created by Jan Dammshäuser on 19.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation

class Addresses {
    static let inst = Addresses()
    
    private var _addresses = [String]()
    
    var addresses: [String] {
        return _addresses
    }
    
    func getAddresses() {
        
        //add something to find addresses and put them into _addresses
        
        _addresses.append("Unter den Linden 77, 10117 Berlin")
        _addresses.append("Rothenbaumchaussee 10, 20148 Hamburg")
        _addresses.append("Promenadepl. 2-6, 80333 München")
        
        GeoCoder.inst.getAnnotationForAddresses(_addresses)
    }
    
}
