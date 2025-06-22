//
//  MemoVM2.swift
//  WishTrip
//
//  Created by 신민정 on 6/22/25.
//

import Foundation
import SwiftUI

class MemoVM2: ObservableObject {
    @Published var destinations: [Destination] = []

    init() {
        destinations = [
            Destination(city: "파리", country: "프랑스", imageName: "paris"),
            Destination(city: "바르셀로나", country: "스페인", imageName: "barcelona"),
            Destination(city: "하와이",     country: "미국",       imageName: "hawaii"),
            Destination(city: "도쿄",       country: "일본",       imageName: "tokyo"),
            Destination(city: "푸꾸옥",     country: "베트남",     imageName: "phuquoc"),
            Destination(city: "뉴욕",       country: "미국",       imageName: "newyork"),
            Destination(city: "발리",       country: "인도네시아", imageName: "bali"),
            Destination(city: "제주",       country: "대한민국",   imageName: "jeju")
        ]
    }
}

