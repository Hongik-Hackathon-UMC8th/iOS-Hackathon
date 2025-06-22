//
//  HomeRouter.swift
//  WishTrip
//
//  Created by 김지우 on 6/22/25.
//


import Foundation
import Moya
import SwiftUI

enum HomeRouter {
    case getGooglePlaceSearch(keyword: String)
    case getCoordinates(place_id: String)
}

extension HomeRouter: APITargetType {
    
    var baseURL: URL {
        switch self {
        case .getGooglePlaceSearch, .getCoordinates:
            return URL(string: "\(Config.googleApiURL)")!
        }
    }
    
    var path: String {
        switch self {
        case .getGooglePlaceSearch:
            return "/autocomplete/json"
        case .getCoordinates:
            return "/details/json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGooglePlaceSearch, .getCoordinates:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getGooglePlaceSearch(let keyword):
            return .requestParameters(parameters: ["input": keyword, "key": "\(Config.apiKey)", "types": "geocode", "language": "ko"], encoding: URLEncoding.queryString)
        case .getCoordinates(let place_id):
            return .requestParameters(parameters: ["place_id": place_id, "key": "\(Config.apiKey)"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getGooglePlaceSearch, .getCoordinates:
            return ["Content-Type": "application/json"]
        }
    }
}

