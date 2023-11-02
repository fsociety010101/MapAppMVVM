//
//  Location.swift
//  MapAppMVVM
//
//  Created by Dmytro Nimchynskyi on 31/10/2023.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    var id: String {
        // name = "CSK"
        // cityName = Lublin
        // id = "CSKLublin"
        name + cityName
    }
    
    /*
     i created computed variable id instead of UUID,
     because if exact same location will be created several times it will be recognised as different places
     */
    
    // equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
}
