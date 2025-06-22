//
//  HomeView.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(NavigationRouter.self) private var router
    @State private var searchText: String = ""
    
    @ObservedObject private var userSession = UserSession.shared


    var body: some View {
        VStack(alignment: .leading){
            //상단로고& 알림
            HStack{
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 96, height: 19)
                
                Spacer()
                    .frame(width: 230)
                
                Image(.alarm)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 19, height: 19)
            }//HStackend
            
            Spacer()
                .frame(height:30)
            
            //검색바
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                TextField("도시 이름을 입력하세요", text: $searchText)
                    .font(.pretend(type: .medium, size: 14))
                    .onTapGesture {
                                router.push(.mapWithSearch(keyword: ""))
                            }
                
                
            }
            .padding(15)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth: 1) // 테두리 색과 두께
            )
            .frame(minWidth: 200, maxWidth: 370)
            
            Spacer()
                .frame(height:10)
            
            HStack
            {
                Spacer()
                    .frame(width:20)
                Text("예: 파리, 뉴욕")
                    .foregroundColor(.gray)
                    .font(.pretend(type: .light, size: 11))

            }
            
            Spacer()
                .frame(height:20)
            
            //여행자님 안녕하세요
            HStack
            {
               
                Image(.user)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                //멘트 스택
                
                
                VStack(alignment: .leading) {
                    Text("\(userSession.userName)님 안녕하세요")
                        .font(.pretend(type: .semiBold, size: 14))
                    
                    Text("여행을 위한 최고의 장소를 찾아보세요!")
                        .font(.pretend(type: .medium, size: 11))
                        .foregroundColor(.gray)
                } // VStackend
                
              
            }//HStackend
            
            //여행지 사진 스크롤뷰(사진 임의로)
            PlaceCardView(places: PlaceCardViewModel)
            
            Spacer()
                .frame(height:20)
            
            Text("내 여행지 목록에 추가해보세요!")
                    .font(.pretend(type:.bold,size:15))
                //여행지 목록에 추가 스크롤뷰
                
            Spacer()
                .frame(height:15)
            
            RecommendationView(recommendations: RecommendationViewModel)
                .padding(.leading, -15)
            
           
        }//전체 VStack
        .padding(.horizontal, 18)
     
            
        
    }//전체 end
}

#Preview {
    HomeView()
        .environment(NavigationRouter())

}
