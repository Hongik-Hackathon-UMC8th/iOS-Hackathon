//
//  FullListView.swift
//  WishTrip
//
//  Created by 신민정 on 6/22/25.
//

import SwiftUI

struct FullListView: View {
    @ObservedObject var viewModel2: MemoVM2
    @Environment(\.dismiss) private var dismiss
    @State private var sortOption: SortOption = .registration
    
    enum SortOption: String, CaseIterable, Identifiable {
        case registration    = "등록일 순"
        case alphabetical    = "가나다 순"
        var id: String { rawValue }
    }

    var body: some View {
        VStack(spacing: 0) {
            // ── 내비바 (뒤로가기) ─────────────────────────
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                Spacer()
                    
            }
            .padding(.horizontal)
            .padding(.top, 10)
        
            

          
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("여행지 목록")
                        .font(.custom("Pretendard-SemiBold", size: 16))
                    Text("여행할 도시 및 완료한 여행지")
                        .font(.custom("Pretendard-Regular", size: 11))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                Spacer()
                Menu {
                    ForEach(SortOption.allCases) { option in
                        Button(option.rawValue) {
                            sortOption = option
                        }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text(sortOption.rawValue)
                            .font(.custom("Pretendard-Regular", size: 10))
                            .foregroundColor(.navy01)
                        Spacer()
                        Image("triangle1")
                            .font(.subheadline)
                            .foregroundColor(.navy01)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .frame(width: 128, height: 19)
                    .background(.gray02)
                    .cornerRadius(5)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 4)

            Divider()
                .padding(.horizontal, 16)
                .padding(.top, 8)

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel2.destinations) { dest in
                        destinationRow(destination: dest)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    func destinationRow(destination: Destination) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(destination.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(destination.city)
                        .font(.custom("Pretendard-Medium", size: 14))
                        .foregroundColor(.city)
                    Text(destination.country)
                        .font(.custom("Pretendard-Regular", size: 11))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button {
                    // your first button action
                } label: {
                    Image("button1")
                        .resizable()
                        .frame(width: 19.45, height: 19.45)
                }
                
                Spacer().frame(width: 17)
                
                Button {
                } label: {
                    Image("button2")
                        .resizable()
                        .frame(width: 21, height: 21)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            Divider()
                .padding(.horizontal, 16)
                .padding(.top, 8)
        }
    }
}

#Preview {
    FullListView(viewModel2: MemoVM2())
}


