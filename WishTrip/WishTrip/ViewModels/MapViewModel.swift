//
//  MapViewModel.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

import SwiftUI
import MapKit
import Observation

@Observable
class MapViewModel {
    var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.550952, longitude: 126.925479),
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
    )
}
