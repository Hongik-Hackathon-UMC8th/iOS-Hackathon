//
//  PlaceCardView.swift
//  WishTrip
//
//  Created by 김지우 on 6/22/25.
//

import SwiftUI

struct PlaceCardView: View {
    let places: [PlaceCardModel]
    
    var body: some View {
        TabView {
            ForEach(places) { place in
                Image(place.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 40, height: 200)
                    .clipped()
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // 페이지 넘김 & 인디케이터
        .frame(height: 220)
    }
}


#Preview {
    PlaceCardView(places: PlaceCardViewModel)
}
