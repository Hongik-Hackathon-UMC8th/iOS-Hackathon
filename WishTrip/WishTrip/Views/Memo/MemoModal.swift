//
//  MemoModal.swift
//  WishTrip
//
//  Created by 김영택 on 6/22/25.
//

import SwiftUI
import PhotosUI

struct MemoModal: View {
    @State private var localSearch: String = ""
    @State private var travelMemo: String = ""
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var activeDatePicker: ActiveDatePicker? = nil
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []


    enum ActiveDatePicker {
        case start, end
    }

    var body: some View {
        // 첫 번째 모달: 초기화 확인
        ZStack{
            Color.black.opacity(0.2)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("장소 선택")
                        .font(.customPretend(.semiBold, size: 16))
                        .foregroundColor(.black)
                    
                    searchTextField("장소 검색", text: $localSearch, strokeColor: .gray)
                    
                    Text("예 : 파리, 뉴욕")
                        .font(.customPretend(.light, size: 13))
                        .foregroundStyle(.gray)
                }
                
                // 일정 날짜
                VStack(alignment: .leading) {
                    Group {
                        Text("일정 날짜")
                            .font(.customPretend(.semiBold, size: 16))
                            .foregroundColor(.black)
                        
                        Spacer().frame(height: 10)
                        
                        DateInputField(title: "여행 시작 날짜", date: startDate) {
                            activeDatePicker = .start
                        }

                        DateInputField(title: "여행 종료 날짜", date: endDate) {
                            activeDatePicker = .end
                        }


                    }
                }
                
                // 여행 내용 기록
                VStack(alignment: .leading, spacing: 15) {
                    Text("여행 내용")
                        .font(.customPretend(.semiBold, size: 16))
                        .foregroundColor(.black)
                    
                    customTextField("특별한 감정을 기록해보세요.", text: $travelMemo, strokeColor: .gray)
                        .font(.customPretend(.regular, size: 15))
                    
                    Text("최소한의 정보를 입력하세요")
                        .font(.customPretend(.light, size: 13))
                        .foregroundStyle(.gray)
                }
                
                // 사진 버튼
                VStack {
                    // 이미지 추가 버튼 (이미지 선택 전까지만 표시)
                    if selectedImages.isEmpty {
                        HStack {
                            Spacer()
                            
                            ZStack {
                                // 이미지 버튼 UI
                                Image("AddPhotoIcon")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.blue)
                                    .padding()
                                
                                // 투명 PhotosPicker
                                PhotosPicker(selection: $selectedItems,
                                             maxSelectionCount: 5,
                                             matching: .images) {
                                    Color.clear
                                }
                                             .frame(width: 25, height: 25)
                            }
                        }
                    }

                    // 선택된 이미지 표시
                    if !selectedImages.isEmpty {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(selectedImages, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipped()
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
                .padding()
                .onChange(of: selectedItems) { oldItems, newItems in
                    selectedImages.removeAll()
                    for item in newItems {
                        Task {
                            if let data = try? await item.loadTransferable(type: Data.self),
                               let image = UIImage(data: data) {
                                selectedImages.append(image)
                            }
                        }
                    }
                }

                
                // 취소 입력하기 버튼
                HStack(spacing: 12) {
                    Button(action: {
                        
                    }) {
                        Text("취소")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .font(.customPretend(.semiBold, size: 16))
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        
                    }) {
                        Text("입력하기")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .font(.customPretend(.semiBold, size: 16))
                            .background(Color.navy01)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                
            }
            .overlay {
                if let picker = activeDatePicker {
                    Color.white.opacity(0.7)
                        .onTapGesture {
                            withAnimation {
                                activeDatePicker = nil
                            }
                        }

                    VStack {
                        DatePicker(
                            "",
                            selection: picker == .start ? $startDate : $endDate,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.graphical)
                        .frame(width: 300, height: 320)
                        .labelsHidden()
                        .padding()

                        Button("닫기") {
                            withAnimation {
                                activeDatePicker = nil
                            }
                        }
                        .font(.system(size: 15))
                        .foregroundColor(.blue)
                        .padding(.bottom)
                    }
                    .background(.white)
                    .cornerRadius(16)
                    .transition(.opacity.combined(with: .scale))
                    .zIndex(1)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 40)
            .shadow(radius: 10)
        }
    }
    
    // MARK: - 검색 텍스트 필드
    @ViewBuilder
    private func searchTextField(
        _ placeholder: String,
        example: String = "",
        text: Binding<String>,
        strokeColor: Color = .gray
    ) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField(placeholder, text: text)
                    .foregroundColor(.black)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(strokeColor, lineWidth: 1)
            )

            if !example.isEmpty {
                Text("예 : \(example)")
                    .font(.customPretend(.regular, size: 15))
                    .foregroundColor(.gray)
                    .padding(.leading, 4)
            }
        }
    }

}

// MARK: - 날짜 입력 필드
struct DateInputField: View {
    let title: String
    let date: Date
    let onTap: () -> Void

    var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    var body: some View {
        Button {
            onTap()
        } label: {
            HStack {
                Text(dateFormatted)
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                Spacer()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
        }
    }
}


#Preview {
    MemoModal()
}
