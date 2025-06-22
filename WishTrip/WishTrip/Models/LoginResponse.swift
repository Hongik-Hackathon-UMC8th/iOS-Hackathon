//
//  LoginResponse.swift
//  WishTrip
//
//  Created by 김영택 on 6/22/25.
//

// 요청 DTOs
struct SignupRequest: Codable {
    let user_id: String
    let user_pwd: String
    let phone_num: String
    let nickname: String
}

struct LoginRequest: Codable {
    let user_id: String
    let user_pwd: String
}

// 응답 DTO
struct MemberResult: Codable {
    let memberId: Int
    let createdAt: String
}

struct ApiResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: MemberResult
}
