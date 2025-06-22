//
//  LoginViewModel.swift
//  WishTrip
//
//  Created by 김영택 on 6/22/25.
//

import Foundation
import Moya
import Observation

@Observable
class LoginViewModel {
    private let provider: MoyaProvider<LoginRouter>
    
    init(provider: MoyaProvider<LoginRouter> = APIManager.shared.createProvider(for: LoginRouter.self)) {
        self.provider = provider
    }
    
    // MARK: - 입력값
    var userId: String = ""
    var userPwd: String = ""
    var phoneNum: String = ""
    var nickname: String = ""
    
    // MARK: - 상태값 (응답값 풀어서 관리)
    var memberId: Int? = nil
    var createdAt: String? = nil
    var isSuccess: Bool = false
    var message: String? = nil
    var errorMessage: String? = nil
    
    // MARK: - 회원가입
    func signup() async {
        let request = SignupRequest(
            user_id: userId,
            user_pwd: userPwd,
            phone_num: phoneNum,
            nickname: nickname
        )
        
        do {
            let response = try await provider.requestAsync(.signup(request))
            let decoded = try JSONDecoder().decode(ApiResponse.self, from: response.data)
            
            self.memberId = decoded.result.memberId
            self.createdAt = decoded.result.createdAt
            self.message = decoded.message
            self.isSuccess = decoded.isSuccess
            self.errorMessage = nil
        } catch {
            self.isSuccess = false
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - 로그인
    func login() async {
        let request = LoginRequest(
            user_id: userId,
            user_pwd: userPwd
        )
        
        do {
            let response = try await provider.requestAsync(.login(request))
            let decoded = try JSONDecoder().decode(ApiResponse.self, from: response.data)
            
            self.memberId = decoded.result.memberId
            self.createdAt = decoded.result.createdAt
            self.message = decoded.message
            self.isSuccess = decoded.isSuccess
            self.errorMessage = nil
        } catch {
            self.isSuccess = false
            self.errorMessage = error.localizedDescription
        }
    }
}
