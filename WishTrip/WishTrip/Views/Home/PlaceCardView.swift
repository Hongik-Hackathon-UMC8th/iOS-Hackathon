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
                GeometryReader { geometry in
                    Image(place.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: 200)
                        .clipped()
                        .aspectRatio(contentMode: .fit)

                        .cornerRadius(20)
                    
                }
                .frame(height: 200)
                .padding(.horizontal, 20)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 220)

    }
}

#Preview {
    PlaceCardView(places: PlaceCardViewModel)
}
