//
//  LoginRouter.swift
//  WishTrip
//
//  Created by 김영택 on 6/22/25.
//

import Foundation
import Moya

enum LoginRouter {
    case signup(SignupRequest)
    case login(LoginRequest)
}

extension LoginRouter: APITargetType {
    
    var baseURL: URL {
        return URL(string: "\(Config.baseURL)")!
    }
    
    var path: String {
        switch self {
        case .signup:
            return "/members/signup"
        case .login:
            return "/members/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signup, .login:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .signup(let request):
            return .requestJSONEncodable(request)
        case .login(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
