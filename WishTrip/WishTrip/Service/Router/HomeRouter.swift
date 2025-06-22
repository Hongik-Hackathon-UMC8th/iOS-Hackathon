//
//  HomeRouter.swift
//  WishTrip
//
//  Created by 김지우 on 6/22/25.
//


import Foundation
import Moya
import SwiftUI

import Foundation
import Moya

enum HomeRouter {
    case getMyName(memberId: Int)
}

extension HomeRouter: APITargetType {
    var baseURL: URL {
        return URL(string: "http://23.22.139.253:8080/")!
    }

    var path: String {
        switch self {
        case .getMyName(let memberId):
            return "/members/\(memberId)/my_name"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
