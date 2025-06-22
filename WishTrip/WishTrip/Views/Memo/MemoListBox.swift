//
//  MemoListBox.swift
//  WishTrip
//
//  Created by 신민정 on 6/22/25.
//

import SwiftUI

struct MemoListBox: View {
    @ObservedObject var viewModel: MemoViewModel
    @State private var showMemoModal = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading){
                HStack{
                    Text("여행 기록")
                        .font(.custom("Pretendard-SemiBold", size: 15))
                    Image("button3")
                }
                Text("특별한 감정 기록하기")
                    .font(.custom("Pretendard-Regular", size: 11))
                    .foregroundColor(.gray01)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal,15)


            ForEach(viewModel.sortedMemos.prefix(1)) { memo in
                MemoCardView(memo: memo)
            }


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
        .padding(.horizontal)
    }
}


