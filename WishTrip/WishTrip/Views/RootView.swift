//
//  RootView.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

import SwiftUI

struct RootView: View {
    @State private var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            BaseTabView()
                .environment(router)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .baseTab:
                        BaseTabView()
                            .environment(router)
                    case .mapWithSearch(let keyword):
                                           MapView(initialKeyword: keyword)
                                               .environment(router)
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
