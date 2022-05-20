//
//  MapAppApp.swift
//  MapApp
//
//  Created by Eugene Yakushev on 14.05.2022.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
