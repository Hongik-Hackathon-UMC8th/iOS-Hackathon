//
//  MemoRouter.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

import Foundation
import Moya
import SwiftUI

enum MemoRouter {
    case getTripRecords(trip_record_id: Int)
    case postTripRecords(request: AddScheduleRequest)
    case getTripRecordsList(memberId: Int)
    case reset(memberId: Int)
}

extension MemoRouter: APITargetType {
    
    var baseURL: URL {
        switch self {
        case .getTripRecords, .postTripRecords, .getTripRecordsList, .reset:
            return URL(string: "\(Config.baseURL)")!
        }
    }
    
    var path: String {
        switch self {
        case .getTripRecords(let memberId):
            return "/api/trip_places/\(memberId)"
        case .postTripRecords:
            return "/trip_records/"
        case .getTripRecordsList(let trip_record_id):
            return "/trip_records/\(trip_record_id)/"
        case .reset(let memberId):
            return "/members/\(memberId)/reset"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTripRecords, .getTripRecordsList:
            return .get
        case .postTripRecords:
            return .post
        case .reset:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getTripRecordsList, .getTripRecords, .reset:
            return .requestPlain
        case .postTripRecords(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getTripRecordsList, .getTripRecords, .reset, .postTripRecords:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqdWxpZTA4MDUxIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3NTA1ODYyMzQsImV4cCI6MTc1MDYwMDYzNH0.YetwfrTOSBwcLrAwY5Cp9F-ztIordaGTYlYEl94eqdw"
            ]
        }
    }
}
