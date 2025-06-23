//
//  MapViewModel.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

import SwiftUI
import MapKit
import Observation
import Moya

@Observable
class MapViewModel {
    let provider: MoyaProvider<MapRouter>
    
    init(provider: MoyaProvider<MapRouter> = APIManager.shared.createProvider(for: MapRouter.self)) {
        self.provider = provider
    }
    
    var keyword: String = ""
    var selected: Prediction?
    
    var showNoResultsAlert = false
    
    var annotations: CLLocationCoordinate2D? = nil
    var cameraPosition: MapCameraPosition = .userLocation(
        fallback: .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.5759, longitude: 126.9768),
                latitudinalMeters: 2000,
                longitudinalMeters: 2000
            )
        )
    )
    
    var results: [Prediction]?
    
    // 도시 검색
    func getPlaceSearch() async {
        do {
            let response = try await provider.requestAsync(.getGooglePlaceSearch(keyword: self.keyword))
            let result = try JSONDecoder().decode(AutocompleteResponse.self, from: response.data)
            
            // 검색결과 중에 도시만 가져오게
            let cities = result.predictions.filter { $0.types.contains("locality") }
            self.results = cities
            
            if self.results?.isEmpty ?? true {
                self.showNoResultsAlert = true
            }
        } catch {
            print("요청 또는 디코딩 실패:", error.localizedDescription)
        }
    }
    
    // 도시 위치 받아오기
    func getLocation(place_id: String) async {
        do {
            let response = try await provider.requestAsync(.getCoordinates(place_id: place_id))
            let decoded = try JSONDecoder().decode(PlaceDetailResponse.self, from: response.data)
            let coord = decoded.result.geometry.location
            
            let center = CLLocationCoordinate2D(latitude: coord.lat, longitude: coord.lng)
            
            let newRegion = MKCoordinateRegion(
                center: center,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            )

            cameraPosition = .region(newRegion)
            annotations = center
        } catch {
            print("요청 또는 디코딩 실패:", error.localizedDescription)
        }
    }
    
    // 여행지 추가
    func postTripPlaces() async -> Bool {
        do {
            guard let selected = selected else { return false }
            
            let newRequest = AddTravelRequest(
                memberId: 2,
                city: selected.structured_formatting.main_text,
                country: selected.structured_formatting.secondary_text
            )
            
            let response = try await provider.requestAsync(.postTripPlaces(request: newRequest))
            let decoded = try JSONDecoder().decode(AddTravelDestinationResponse.self, from: response.data)

            return decoded.isSuccess
        } catch {
            print("요청 또는 디코딩 실패:", error.localizedDescription)
            return false
        }
    }
}

extension MoyaProvider {
    func requestAsync(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
