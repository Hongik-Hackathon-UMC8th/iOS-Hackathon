//
//  SignInView.swift
//  WishTrip
//
//  Created by 김영택 on 6/22/25.
//

import SwiftUI

struct SignInView: View {
    
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var isLoginAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @State private var isLoginSuccess: Bool? = nil
    
    @Bindable var viewModel = LoginViewModel()
    var body: some View {
        VStack {
            Image("WishTripLogo")
            
            Spacer().frame(height:310)
            
            VStack(spacing: 10) {
                // 아이디 입력 필드
                TextField("ID", text: $id)
                    .padding()
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.navy01, lineWidth: 1))
                
                // Password Field
                SecureField("PW", text: $password)
                    .padding()
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.navy01, lineWidth: 1))
                
                // Login Button
                Button(action: {
                    if id.isEmpty || password.isEmpty {
                        isLoginAlert = true
                    } else {
                        Task {
                            viewModel.loginId = id
                            viewModel.loginPwd = password
                            await login()
                        }
                    }
                }) {
                    Text("로그인")
                        .foregroundStyle(.white)
                        .font(.customPretend(.medium, size: 18))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.navy01)
                        .cornerRadius(10)
                }

                // 회원가입 버튼
                Button(action: {
                    // 회원가입 페이지로 이동
                }) {
                    Text("회원가입")
                        .foregroundStyle(.white)
                        .font(.customPretend(.medium, size: 18))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.navy01)
                        .cornerRadius(10)
                }
                
                if !alertMessage.isEmpty {
                                    Text(alertMessage)
                                        .font(.caption)
                                        .foregroundColor(isLoginSuccess == true ? .green : .red)
                                        .padding(.top, 10)
                                }
            }
            .padding(.horizontal, 50)
        }
        .alert(isPresented: $isLoginAlert) {
            Alert(title: Text("아이디/비밀번호를 전부 입력하세요"), dismissButton: .default(Text("확인")))
        }
    }
    
    private func login() async {

        await viewModel.login()

        isLoginSuccess = viewModel.isSuccess
                alertMessage = viewModel.isSuccess
                    ? "✅ 로그인 성공: \(viewModel.message ?? "")"
                    : "❌ 로그인 실패: \(viewModel.message ?? "알 수 없는 오류")"
        }

}

#Preview {
    SignInView()
}
