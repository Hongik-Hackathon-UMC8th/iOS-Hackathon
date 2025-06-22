import SwiftUI

struct SignUpView: View {
    
    // MARK: - States
    @Bindable var viewModel = LoginViewModel()
    
    @State private var id = ""
    @State private var password = ""
    @State private var checkPassword = ""
    @State private var name = ""
    @State private var callNumber = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""

    // MARK: - Validation
    private var isFormValid: Bool {
        [id, password, checkPassword, name, callNumber].allSatisfy { !$0.isEmpty }
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image("WishTripLogo")
            Spacer().frame(height: 150)

            VStack(spacing: 10) {
                customTextField("ID", text: $id, strokeColor: Color.navy01)
                customSecureField("PW", text: $password, strokeColor: Color.navy01)
                customSecureField("비밀번호 다시 입력", text: $checkPassword, strokeColor: Color.navy01)
                customTextField("이름", text: $name, strokeColor: Color.navy01)
                customTextField("전화번호", text: $callNumber, strokeColor:    Color.navy01)

                Spacer().frame(height: 10)

                Button("회원가입", action: handleSignUp)
                    .foregroundStyle(.white)
                    .font(.customPretend(.medium, size: 18))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.navy01)
                    .cornerRadius(10)
                
                // 에러 메시지 있으면 화면에 출력 + 콘솔 출력
                                if let error = viewModel.errorMessage {
                                    Text("❌ \(error)")
                                        .foregroundColor(.red)
                                        .padding(.top, 8)
                                    // 콘솔 출력
                                    .task {
                                        print("Error Message: \(error)")
                                    }
                                }

                                // 성공 메시지 있으면 화면에 출력 + 콘솔 출력
                                if viewModel.isSuccess {
                                    Text("✅ 가입 완료! ID: \(viewModel.memberId ?? 0)")
                                        .foregroundColor(.green)
                                        .padding(.top, 8)
                                    // 콘솔 출력
                                    .task {
                                        print("Success! Member ID: \(viewModel.memberId ?? 0)")
                                    }
                                }

                

            }
            .padding(.horizontal, 50)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage), dismissButton: .default(Text("확인")))
        }
    }

    // MARK: - Actions
    private func handleSignUp() {
        if !isFormValid {
            alertMessage = "모든 칸을 입력하세요."
        } else if password != checkPassword {
            alertMessage = "비밀번호가 일치하지 않습니다."
        } else {
            // 회원가입 성공 처리
            Task {
                await viewModel.signup()
            }
        }
        showAlert = true
    }
}

// MARK: - Components
@ViewBuilder
func customTextField(_ placeholder: String, text: Binding<String>, strokeColor: Color = .navy01) -> some View {
    TextField(placeholder, text: text)
        .padding()
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(strokeColor, lineWidth: 1)
        )
}

@ViewBuilder
func customSecureField(_ placeholder: String, text: Binding<String>, strokeColor: Color = .navy01) -> some View {
    SecureField(placeholder, text: text)
        .padding()
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(strokeColor, lineWidth: 1)
        )
}
#Preview {
    SignUpView()
}
