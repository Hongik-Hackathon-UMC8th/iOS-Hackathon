//
//  MemoDetailViewModel.swift
//  WishTrip
//
//  Created by 이가원 on 6/22/25.
//
import SwiftUI
import Foundation


import Foundation

class MemoViewModel: ObservableObject {
    @Published var memos: [Memo] = [
        Memo(
            imageName: "paris3",
            title: "파리",
            subtitle: "프랑스의 수도",
            content: "프랑스 파리에 처음 방문했을 때 안 좋은 편견이 있었지만 편견은 편견일 뿐 사람들도 친절하고 넘 재밌었당 또가고 싶다 프랑스짱 루브르 박물관에 있는 모나리자는 가품일까? 진품일까?",
            startDate: Date(timeIntervalSince1970: 1685932800),
            endDate: Date(timeIntervalSince1970: 1687219200),
            createdAt: Date(timeIntervalSince1970: 1687737600) 
        ),
        Memo(
            imageName: "hawaii3",
            title: "하와이",
            subtitle: "미국의 섬",
            content: "프랑스 파리에 처음 방문했을 때 안 좋은 편견이 있었지만 편견은 편견일 뿐 사람들도 친절하고 넘 재밌었당 또가고 싶다 프랑스짱 루브르 박물관에 있는 모나리자는 가품일까? 진품일까?",
            startDate: Date(timeIntervalSince1970: 1685932800),
            endDate: Date(timeIntervalSince1970: 1687219200),
            createdAt: Date(timeIntervalSince1970: 1687737600)
        ),
        Memo(
            imageName: "barcelona3",
            title: "바르셀로나",
            subtitle: "스페인의 도시",
            content: "프랑스 파리에 처음 방문했을 때 안 좋은 편견이 있었지만 편견은 편견일 뿐 사람들도 친절하고 넘 재밌었당 또가고 싶다 프랑스짱 루브르 박물관에 있는 모나리자는 가품일까? 진품일까?",
            startDate: Date(timeIntervalSince1970: 1685932800),
            endDate: Date(timeIntervalSince1970: 1687219200),
            createdAt: Date(timeIntervalSince1970: 1687737600)
        )
    ]

    @Published var sortOption: MemoSortOption = .travelDate

    var sortedMemos: [Memo] {
        switch sortOption {
        case .travelDate:
            return memos.sorted { $0.startDate < $1.startDate }
        case .createdDate:
            return memos.sorted { $0.createdAt < $1.createdAt }
        case .alphabetical:
            return memos.sorted { $0.title < $1.title }
        }
    }

    func updateSortOption(to optionString: String) {
        if let option = MemoSortOption.allCases.first(where: { $0.rawValue == optionString }) {
            sortOption = option
        }
    }
}
