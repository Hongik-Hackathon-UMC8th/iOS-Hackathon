//
//  MemoModel.swift
//  WishTrip
//
//  Created by 신민정 on 6/22/25.
//

import SwiftUI
import Foundation

struct Destination: Identifiable {
    let id = UUID()
    let city: String
    let country: String
    let imageName: String
}

