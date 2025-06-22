//
//  CustomModalView2.swift
//  WishTrip
//
//  Created by 김영택 on 6/22/25.
//

import SwiftUI

struct CustomModalView2: View {
    let title: String
    let locationTitle: String
    let locationSubtitle: String
    let primaryButtonTitle: String
    var secondaryButtonTitle: String? = nil
    let primaryAction: () -> Void
    var secondaryAction: (() -> Void)? = nil

    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                
                Spacer().frame(height: 7)
                // 제목
                Text(title)
                    .font(.customPretend(.semiBold, size: 16))
                    .foregroundColor(.black)

                // 장소 정보
                VStack(alignment: .leading, spacing: 4) {
                    Text(locationTitle)
                        .font(.customPretend(.semiBold, size: 16))
                        .foregroundColor(Color.navy01)

                    Text(locationSubtitle)
                        .font(.customPretend(.medium, size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer().frame(height: 2)

                // 버튼
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
    CustomModalView2(
        title: "'내 여행지'에 추가하시겠습니까?",
        locationTitle: "로마",
        locationSubtitle: "이탈리아의 수도",
        primaryButtonTitle: "추가하기",
        secondaryButtonTitle: "취소",
        primaryAction: { print("추가 완료") },
        secondaryAction: { print("취소됨") }
    )
}
