//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Eugene Yakushev on 16.05.2022.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    // all loaded locations
    @Published var locations: [Location]
    
    // current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of locations
    @Published var showLocationList: Bool = false
    
    // show locationDetail via sheet
    @Published var sheetLocation: Location? = nil
    
    init () {
        let locations = LocationsDataService.locations
        self.locations = locations // все локации
        self.mapLocation = locations.first! // конкретно текущая локация
        
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion (location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    func toggleLocationsList () {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    func nextButtonPressed() {
        // get the current index
        guard
            let currentIndex = locations.firstIndex(where: { $0 == mapLocation })
        else { return }
         
        // Chect if the nextIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is NOT valid
            // Restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return }
        // Next index IS valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
