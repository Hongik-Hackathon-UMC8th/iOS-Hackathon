//
//  MemoListBox.swift
//  WishTrip
//
//  Created by 신민정 on 6/22/25.
//

import SwiftUI

import SwiftUI

struct MemoListBox: View {
    @ObservedObject var viewModel: MemoViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("여행 기록")
                .font(.headline)
            Text("특별한 감정 기록하기")
                .font(.subheadline)
                .foregroundColor(.gray)

            // ✂️ 앞에서 하나만 잘라서 보여준다
            ForEach(viewModel.sortedMemos.prefix(1)) { memo in
                MemoCardView(memo: memo)
            }

            // 🚀 더보기 누르면 디테일 전체 보기
            NavigationLink {
                MemoDetail(memo: viewModel.sortedMemos.first!)
            } label: {
                Text("더보기")
                    .font(.body)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}


