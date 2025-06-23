//
//  MapRouter.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

import Foundation
import Moya
import SwiftUI

enum MapRouter {
    case getGooglePlaceSearch(keyword: String)
    case getCoordinates(place_id: String)
    case postTripPlaces(request: AddTravelRequest)
}

extension MapRouter: APITargetType {
    
    var baseURL: URL {
        switch self {
        case .getGooglePlaceSearch, .getCoordinates:
            return URL(string: "\(Config.googleApiURL)")!
        case .postTripPlaces:
            return URL(string: "\(Config.baseURL)")!
        }
    }
    
    var path: String {
        switch self {
        case .getGooglePlaceSearch:
            return "/autocomplete/json"
        case .getCoordinates:
            return "/details/json"
        case .postTripPlaces:
            return "/api/trip_places"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGooglePlaceSearch, .getCoordinates:
            return .get
        case .postTripPlaces:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getGooglePlaceSearch(let keyword):
            return .requestParameters(parameters: ["input": keyword, "key": "\(Config.apiKey)", "types": "geocode", "language": "ko"], encoding: URLEncoding.queryString)
        case .getCoordinates(let place_id):
            return .requestParameters(parameters: ["place_id": place_id, "key": "\(Config.apiKey)"], encoding: URLEncoding.queryString)
        case .postTripPlaces(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getGooglePlaceSearch, .getCoordinates:
            return ["Content-Type": "application/json"]
        case .postTripPlaces:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqdWxpZTA4MDUxIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3NTA1ODYyMzQsImV4cCI6MTc1MDYwMDYzNH0.YetwfrTOSBwcLrAwY5Cp9F-ztIordaGTYlYEl94eqdw"
            ]
        }
    }
}
