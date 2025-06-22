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
    
    @State private var nickname: String = "여행자" // 초기 닉네임
    private let memberId: Int = 1 // 테스트용 ID (실제 로그인 값으로 교체하세요)

    var body: some View {
        VStack(alignment: .leading){
            // 상단 로고 & 알림
            HStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 96, height: 19)
                
                Spacer().frame(width: 230)
                
                Image(.alarm)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 19, height: 19)
            }
            
            Spacer().frame(height: 30)
            
            // 검색바
            HStack {
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
                    .stroke(Color.gray, lineWidth: 1)
            )
            .frame(minWidth: 200, maxWidth: 370)
            
            Spacer().frame(height: 10)
            
            HStack {
                Spacer().frame(width: 20)
                Text("예: 파리, 뉴욕")
                    .foregroundColor(.gray)
                    .font(.pretend(type: .light, size: 11))
            }
            
            Spacer().frame(height: 20)
            
            
            HStack {
                Image(.user)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading) {
                    Text("\(nickname)님 안녕하세요")
                        .font(.pretend(type: .semiBold, size: 14))
                    
                    Text("여행을 위한 최고의 장소를 찾아보세요!")
                        .font(.pretend(type: .medium, size: 11))
                        .foregroundColor(.gray)
                }
            }
            
            PlaceCardView(places: PlaceCardViewModel)
            
            Spacer().frame(height: 20)
            
            Text("내 여행지 목록에 추가해보세요!")
                .font(.pretend(type: .bold, size: 15))
            
            Spacer().frame(height: 15)
            
            RecommendationView(recommendations: RecommendationViewModel)
                .padding(.leading, -15)
        }
        .padding(.horizontal, 18)
        .onAppear {
            fetchNickname()
        }
    }

    
    func fetchNickname() {
            let provider = APIManager.shared.createProvider(for: HomeRouter.self)
            provider.request(.getMyName(memberId: memberId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoded = try JSONDecoder().decode(NicknameResult.self, from: response.data)
                        nickname = decoded.nickname
                    } catch {
                        print("디코딩 오류: \(error)")
                    }
                case .failure(let error):
                    print("요청 실패: \(error)")
                }
            }
        }
}


#Preview {
    HomeView()
        .environment(NavigationRouter())

}
