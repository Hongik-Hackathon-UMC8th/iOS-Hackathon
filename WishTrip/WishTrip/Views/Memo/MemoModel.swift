//
//  MemoDetailModel.swift
//  WishTrip
//
//  Created by 이가원 on 6/22/25.
//
import Foundation

struct Memo: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String
    let content: String
    let startDate: Date
    let endDate: Date
    let createdAt: Date

    var dateRange: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        return "\(formatter.string(from: startDate)) ~ \(formatter.string(from: endDate))"
    }
}

enum MemoSortOption: String, CaseIterable {
    case travelDate
    case createdDate
    case alphabetical

    var displayName: String {
        switch self {
        case .travelDate: return "여행 날짜 순"
        case .createdDate: return "작성일 순"
        case .alphabetical: return "가나다 순"
        }
    }
}
