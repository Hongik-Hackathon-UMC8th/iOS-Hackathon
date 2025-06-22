//
//  RecommendationView.swift
//  WishTrip
//
//  Created by 김지우 on 6/22/25.
//

import SwiftUI

struct RecommendationView: View {
    let recommendations: [RecommendationModel]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
               
                ForEach(recommendations) { recommendation in
                    ZStack {
                        // 배경 이미지 (확대된 상태)
                        
                        Rectangle()
                            .frame(width: 300, height: 350)
                            .overlay(
                                Image(recommendation.imageName)
                                    .resizable()
                                    .scaledToFill()
                            )
                            .clipped()
                            .offset(y:-25)

                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.navy01.opacity(0.64))
                                .frame(width: 75, height: 40)

                            Text(recommendation.tripType)
                                .font(.pretend(type: .medium, size: 9))
                                .foregroundColor(.white)
                                .offset(x: 7, y: 6)

                            
                        }
                        .offset(x: -55, y: -95)

                        // 테두리
                        
                        
                        ZStack{
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 160, height: 70)
                                .overlay(
                                        VStack(alignment: .leading) {
                                            Text(recommendation.country)
                                                .font(.pretend(type: .light, size: 11))
                                                .foregroundColor(.navy01)

                                            Text(recommendation.city)
                                                .font(.pretend(type: .medium, size: 14))
                                            Spacer()
                                                .frame(height:10)
                                        }
                                        .padding(.leading, 12), // 좌측 여백 조절
                                        alignment: .leading // overlay 정렬
                                    )                                .offset(y:80)

                           

                                

                        }

                        RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(1), lineWidth: 99)
                        
                    }
                    .frame(width: 160, height: 200)
                    .overlay( 
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 2.5)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    
                }
                
            }
            .padding(.horizontal)
        }
    }
}



    
#Preview {
    RecommendationView(recommendations: RecommendationViewModel)
}
    

