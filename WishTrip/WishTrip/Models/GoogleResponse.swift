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


/// 여행지 기록 생성 요청 보내는 구조체
struct AddTravelRequest: Codable {
    let memberId: Int
    let country: String
    let city: String
//    let imageUrl: String?
    
    init(memberId: Int, city: String, country: String) {
        self.memberId = memberId
        self.country = country
        self.city = city
//        self.imageUrl = imageUrl
    }
}

struct AddTravelDestinationResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: TravelDestinationResult
}

struct TravelDestinationResult: Codable {
    let tripPlaceId: Int
    let country: String
    let city: String
    let completed: Bool
    let imageUrl: String?
}
