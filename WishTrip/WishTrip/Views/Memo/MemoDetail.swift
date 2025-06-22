//
//  MemoDetail.swift
//  WishTrip
//
//  Created by 이가원 on 6/22/25.
//


import SwiftUI

struct MemoDetail: View {
    let memo: Memo
    @StateObject private var viewModel = MemoViewModel()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(spacing: 0) {
            topView
            ScrollView {
                titleView
                    .padding(.bottom, 29)
                VStack(spacing: 24) {
                                    ForEach(viewModel.sortedMemos) { memo in
                                        MemoCardView(memo: memo)
                                    }
                                }
                                .padding(.horizontal, 0)
                            }
                        }
                        .navigationBarHidden(true)
                    }

    private var topView: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(.back)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(height: 64)
    }

    private var titleView: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 5) {
                Text("여행 기록")
                    .font(.custom("Pretendard-SemiBold", size: 15))

                Text("특별한 감정 기록")
                    .font(.custom("Pretendard-Regular", size: 11))
                    .foregroundColor(.gray01)
            }

            Spacer()

            Menu {
                ForEach(MemoSortOption.allCases, id: \.self) { option in
                    Button {
                        viewModel.sortOption = option
                    } label: {
                        Text(option.displayName)
                            .font(.custom("Pretendard-Regular", size: 10))
                    }
                }
            } label: {
                HStack(spacing: 4) {
                    Text(viewModel.sortOption.displayName)
                        .font(.custom("Pretendard-Regular", size: 10))
                        .foregroundColor(.navy01)
                    Spacer()
                    Image("triangle1")
                        .resizable()
                        .frame(width: 6.17, height: 5.41)
                        .foregroundColor(.blue)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 2)
                .frame(width: 128, height: 19)
                .background(Color.gray02)
                .cornerRadius(5)
            }
        }
        .padding(.horizontal, 20)
    }

    private var memoListView: some View {
        VStack(spacing: 24) {
            ForEach(viewModel.sortedMemos) { memo in
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
}


