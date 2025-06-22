//
//  Config.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

import Foundation

enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist 없음")
        }
        return dict
    }()
    
    static let googleApiURL: String = {
        guard let googleApiURL = Config.infoDictionary["GOOGLE_API_URL"] as? String else {
            fatalError()
        }
        return googleApiURL
    }()
    
    static let signUpApiURL: String = {
        guard let signUpApiURL = Config.infoDictionary["SIGNUP_API_URL"] as? String else {
            fatalError()
        }
        return signUpApiURL
    }()
    
    static let apiKey: String = {
        guard let apiKey = Config.infoDictionary["API_KEY"] as? String else {
            fatalError()
        }
        return apiKey
    }()
}
