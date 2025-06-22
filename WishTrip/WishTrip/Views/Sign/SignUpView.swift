import SwiftUI

struct SignUpView: View {
    
    // MARK: - States
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
                customTextField("ID", text: $id)
                customSecureField("PW", text: $password)
                customSecureField("비밀번호 다시 입력", text: $checkPassword)
                customTextField("이름", text: $name)
                customTextField("전화번호", text: $callNumber)

                Spacer().frame(height: 10)

                Button("회원가입", action: handleSignUp)
                    .foregroundStyle(.white)
                    .font(.customPretend(.medium, size: 18))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.navy01)
                    .cornerRadius(10)
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
            return
        }
        showAlert = true
    }

    // MARK: - Components
    @ViewBuilder
    private func customTextField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding()
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.navy01, lineWidth: 1))
    }

    @ViewBuilder
    private func customSecureField(_ placeholder: String, text: Binding<String>) -> some View {
        SecureField(placeholder, text: text)
            .padding()
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.navy01, lineWidth: 1))
    }
}

#Preview {
    SignUpView()
}
