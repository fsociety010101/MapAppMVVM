//
//  MapAppMVVMApp.swift
//  MapAppMVVM
//
//  Created by Dmytro Nimchynskyi on 31/10/2023.
//

import SwiftUI

@main
struct MapAppMVVMApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
