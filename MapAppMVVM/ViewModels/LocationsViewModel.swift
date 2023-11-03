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
    
    // current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    // default map span
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // show list of locations
    @Published var showLocationsList: Bool = false
    
    // show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
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
    
    public func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    public func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    public func nextButtonPressed() {
        
        // get index of current location
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find index at locations array!")
            return
        }
        
        // check if current index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // next index IS NOT valid
            // restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // next index IS valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
