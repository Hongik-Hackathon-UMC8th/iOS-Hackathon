import SwiftUI

struct SettingView: View {
    @State private var showResetModal = false
    @State private var showResetCompleteModal = false

    var body: some View {
        ZStack {
            NavigationStack {
                VStack(alignment: .leading, spacing: 0) {
                    resetButton
                    Divider()
                    Spacer()
                }
                .navigationTitle("설정")
                .navigationBarTitleDisplayMode(.inline)
            }

            if showResetModal {
                CustomModalView(
                    title: "내 위시트립을 초기화하겠습니까?",
                    message: "초기화 후 되돌릴 수 없습니다.",
                    primaryButtonTitle: "초기화하기",
                    secondaryButtonTitle: "취소",
                    primaryAction: {
                        showResetModal = false
                        showResetCompleteModal = true
                    },
                    secondaryAction: {
                        showResetModal = false
                    }
                )
            }

            if showResetCompleteModal {
                CustomModalView(
                    title: "내 위시트립이 초기화되었습니다.",
                    message: "다시 나만의 위시트립을 채워봐요!",
                    primaryButtonTitle: "닫기",
                    primaryAction: {
                        showResetCompleteModal = false
                    }
                )
            }
        }
    }

    private var resetButton: some View {
        Button(action: {
            showResetModal = true
        }) {
            VStack(alignment: .leading, spacing: 4) {
                Text("내 위시트립 초기화")
                    .font(.customPretend(.semiBold, size: 16))
                    .foregroundColor(.black)
                Text("입력한 내용을 모두 초기화할 수 있어요")
                    .font(.customPretend(.regular, size: 14))
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

struct CustomModalView: View {
    let title: String
    let message: String
    let primaryButtonTitle: String
    var secondaryButtonTitle: String? = nil
    let primaryAction: () -> Void
    var secondaryAction: (() -> Void)? = nil

    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                Spacer().frame(height: 10)

                Text(title)
                    .font(.customPretend(.semiBold, size: 16))
                    .foregroundColor(.black)

                Spacer().frame(height: 10)

                Text(message)
                    .font(.customPretend(.medium, size: 16))
                    .foregroundColor(Color.navy01)

                Spacer().frame(height: 40)

                if let secondaryTitle = secondaryButtonTitle,
                   let secondaryAction = secondaryAction {
                    HStack(spacing: 12) {
                        modalButton(title: secondaryTitle, background: Color.gray.opacity(0.2), foreground: .black, action: secondaryAction)
                        modalButton(title: primaryButtonTitle, background: Color.navy01, foreground: .white, action: primaryAction)
                    }
                } else {
                    modalButton(title: primaryButtonTitle, background: Color.navy01, foreground: .white, action: primaryAction)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 40)
            .shadow(radius: 10)
        }
    }

    private func modalButton(title: String, background: Color, foreground: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .font(.customPretend(.semiBold, size: 16))
                .background(background)
                .foregroundColor(foreground)
                .cornerRadius(10)
        }
    }
}

#Preview {
    SettingView()
}
