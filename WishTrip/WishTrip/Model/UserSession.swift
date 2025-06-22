//
//  UserSession.swift
//  WishTrip
//
//  Created by 김지우 on 6/22/25.
//

import Foundation


@MainActor
final class UserSession: ObservableObject {
    static let shared = UserSession()
    
    
    private let userNameKey = "userName"
    
    
    @Published var userName: String {
        didSet {
            UserDefaults.standard.set(userName, forKey: userNameKey)
        }
    }
    
    private init() {
        self.userName = UserDefaults.standard.string(forKey: userNameKey) ?? "여행자"
    }
}
