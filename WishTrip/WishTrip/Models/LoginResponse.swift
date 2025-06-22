//
//  LoginResponse.swift
//  WishTrip
//
//  Created by 김영택 on 6/22/25.
//

// 요청 DTOs
struct SignupRequest: Codable {
    let loginId: String
    let loginPwd: String
    let phone: String
    let nickname: String
}

struct LoginRequest: Codable {
    let loginId: String
    let loginPwd: String
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

// login Response DTO
struct LoginResult: Codable {
    let memberId: Int
    let accessToken: String
}

struct LoginResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: LoginResult
}
