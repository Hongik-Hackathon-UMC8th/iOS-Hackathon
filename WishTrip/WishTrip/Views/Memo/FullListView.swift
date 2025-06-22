//
//  FullListView.swift
//  WishTrip
//
//  Created by 신민정 on 6/22/25.
//

import SwiftUI

struct FullListView: View {
    @ObservedObject var viewModel: MemoVM2
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
        
            VStack(alignment: .leading, spacing: 4) {
                Text("여행지 목록")
                    .font(.callout.bold())
                Text("여행할 도시 및 완료한 여행지")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)  
            .padding(.horizontal)
            .padding(.top, 4)

          
            HStack {
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
                            .font(.subheadline)
                            .foregroundColor(.black)
                        Image(systemName: "chevron.down")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.memomain)
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 4)

            Divider()
                .padding(.horizontal, 16)
                .padding(.top, 8)

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.destinations) { dest in
                        DestinationRow(destination: dest)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    FullListView(viewModel: MemoVM2())
}


