//
//  MemoResponse.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

// 여행 기록 생성 요청 구조체
struct AddScheduleRequest: Codable {
    let memberId: Int
    let placeId: Int
    let startDate: String
    let endDate: String
    let content: String
}

// 여행 기록 생성, 조회 응답 구조체
struct AddScheduleResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ScheduleResult
}

struct ScheduleResult: Codable {
    let id: Int
    let placeCity: String
    let memberName: String
    let startDate: String
    let endDate: String
    let content: String
}

// 초기화 응답 구조체
struct GetMemberIdResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: MemberIdResult
}

struct MemberIdResult: Codable {
    let memberId: Int
}
