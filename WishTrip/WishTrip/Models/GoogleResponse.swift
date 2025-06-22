//
//  GoogleResponse.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

struct AutocompleteResponse: Codable {
    let predictions: [Prediction]
}

struct Prediction: Codable {
    let place_id: String
    let structured_formatting: StructuredFormatting
    let types: [String]
}

struct StructuredFormatting: Codable {
    let main_text: String
    let secondary_text: String
}


struct PlaceDetailResponse: Codable {
    let result: PlaceResult
}

struct PlaceResult: Codable {
    let geometry: Geometry
}

struct Geometry: Codable {
    let location: Coordinate
}

struct Coordinate: Codable {
    let lat: Double
    let lng: Double
}
