//
//  MemoCardView.swift
//  WishTrip
//
//  Created by 신민정 on 6/22/25.
//

import SwiftUI

struct MemoCardView: View {
    let memo: Memo

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                Image(memo.imageName)
                    .resizable()
                    .frame(width: 88, height: 88)
                    .cornerRadius(10)

                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(memo.title)
                            .font(.custom("Pretendard-Medium", size: 14))
                            .foregroundColor(.navy01)
                        Text(memo.subtitle)
                            .font(.custom("Pretendard-Regular", size: 12))
                            .foregroundColor(.gray01)
                    }

                    Text(memo.dateRange)
                        .font(.custom("Pretendard-Regular", size: 11))
                        .foregroundColor(.gray03)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray02)
                        .cornerRadius(3)
                        .padding(.bottom, 5)

                    Text(memo.content)
                        .font(.custom("Pretendard-Regular", size: 11))
                        .foregroundColor(.gray03)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal, 20)

            Divider()
                .padding(.horizontal, 20)
                .padding(.top,10)
        }
    }
}
