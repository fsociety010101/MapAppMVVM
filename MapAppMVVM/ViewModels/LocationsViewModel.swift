//
//  LocationsViewModel.swift
//  MapAppMVVM
//
//  Created by Dmytro Nimchynskyi on 31/10/2023.
//

import Foundation
import SwiftUI
import MapKit


class LocationsViewModel: ObservableObject {
    
    // all loaded locations
    @Published var locations: [Location]
    
    // to track current location on the map
    @Published var mapLocation: Location {
        didSet {
            // every time i update map region -> current location updates automatically
            updateMapRegion(location: mapLocation)
        }
    }
    
    // current map region
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    // default map span 
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        // set all locations from api
        let locations = LocationsDataService.locations
        self.locations = locations
        
        //
        self.mapLocation = locations.first!
        
        // map region to show on map
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan
            )
        }
    }
}
