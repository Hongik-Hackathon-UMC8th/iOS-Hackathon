//
//  RecommendationModel.swift
//  WishTrip
//
//  Created by 김지우 on 6/22/25.
//

import Foundation

struct RecommendationModel: Identifiable, Hashable {
    let id = UUID()
    var imageName: String
    var tripType: String
    var country: String
    var city: String
}
