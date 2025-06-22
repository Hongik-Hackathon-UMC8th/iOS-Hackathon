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
    var loginId: String = ""
    var loginPwd: String = ""
    var phone: String = ""
    var nickname: String = ""
    
    // MARK: - 상태값 (응답값 풀어서 관리)
    var memberId: Int? = nil
    var createdAt: String? = nil
    var isSuccess: Bool = false
    var message: String? = nil
    var code: String? = nil
    var accessToken: String? = nil
    
    // MARK: - Keychain
    var tokenInfo: TokenInfo?
    
    // MARK: - 회원가입
    func signup() async {
        let request = SignupRequest(
            loginId: loginId,
            loginPwd: loginPwd,
            phone: phone,
            nickname: nickname
        )
        
        do {
            let response = try await provider.requestAsync(.signup(request))
            let decoded = try JSONDecoder().decode(ApiResponse.self, from: response.data)
            
            self.memberId = decoded.result.memberId
            self.createdAt = decoded.result.createdAt
            self.message = decoded.message
            self.isSuccess = decoded.isSuccess
            self.code = decoded.code
        } catch {
            self.isSuccess = false
            self.message = error.localizedDescription
        }
    }
    
    // MARK: - 로그인
    func login() async {
        let request = LoginRequest(
            loginId: loginId,
            loginPwd: loginPwd
        )
        
        do {
            let response = try await provider.requestAsync(.login(request))
            let decoded = try JSONDecoder().decode(LoginResponse.self, from: response.data)
            
            self.memberId = decoded.result.memberId
            self.accessToken = decoded.result.accessToken
            self.message = decoded.message
            self.isSuccess = decoded.isSuccess
            self.code = decoded.code
        } catch {
            self.isSuccess = false
            self.message = error.localizedDescription
        }
    }
    
}
