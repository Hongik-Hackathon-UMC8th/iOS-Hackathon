//
//  SettingViewModel.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

import SwiftUI
import MapKit
import Observation
import Moya

@Observable
class SettingViewModel {
    let provider: MoyaProvider<MemoRouter>
    
    init(provider: MoyaProvider<MemoRouter> = APIManager.shared.createProvider(for: MemoRouter.self)) {
        self.provider = provider
    }
    
    // 위시트립 초기화
    func reset() async -> Bool {
        do {
            let response = try await provider.requestAsync(.reset(memberId: 2))
            let result = try JSONDecoder().decode(GetMemberIdResponse.self, from: response.data)
            
            return result.isSuccess
        } catch {
            print("요청 또는 디코딩 실패:", error.localizedDescription)
            return false
        }
    }
}
