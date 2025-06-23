//
//  RootView.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

import SwiftUI

struct RootView: View {
    @State private var router = NavigationRouter()
    @State private var viewModel = MapViewModel()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            SignInView()
                .environment(router)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .login:
                        SignInView()
                            .environment(router)
                    case .signup:
                        SignUpView()
                            .environment(router)
                    case .baseTab:
                        BaseTabView()
                            .environment(router)
                            .environment(viewModel)
                    case .mapWithSearch(let keyword):
                        MapView(initialKeyword: keyword)
                               .environment(router)
                    case .mapView:
                        MapView(initialKeyword: "")
                            .environment(router)
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
