//
//  BaseTabView.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

import SwiftUI

struct BaseTabView: View {
    var body: some View {
        TabView {
            Tab("홈", image: "Home") {
                HomeView()
            }
            Tab("지도", image: "Map") {
                MapView()
            }
            Tab("기록", image: "Memo") {
                MemoView()
            }
            Tab("설정", image: "Setting") {
                SettingView()
            }
        }
        .tint(.navy01)
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
            UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        }
    }
}

#Preview {
    BaseTabView()
}
