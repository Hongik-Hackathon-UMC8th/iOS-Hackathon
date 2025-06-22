//
//  MapView.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    let initialKeyword: String
    @Environment(NavigationRouter.self) private var router
    
    @State private var viewModel: MapViewModel = .init()
    
    @State private var showAddModal = false
    @State private var showCompleteModal = false
    
    @State private var showErrorModal = false
    
    @FocusState private var focusedField: Bool
    @Namespace var mapScope
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    Spacer()
                    
                    Text("지도")
                        .foregroundStyle(.black)
                        .font(.customPretend(.semiBold, size: 16))
                    
                    Spacer()
                }
                .padding(.vertical, 20)
                
                ZStack(alignment: .top) {
                    if ((viewModel.selected) != nil) {
                        mapView
                            .padding(.top, 60)
                    } else {
                        emptyStateView
                            .padding(.top, 45)
                    }
                    
                    if !(viewModel.results?.isEmpty ?? true) {
                        dropDownView
                            .offset(y: 35)
                    }
                    
                    searchBar
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            
            if showAddModal, let selected = viewModel.selected {
                CustomModalView2(
                    title: "'내 여행지'에 추가하시겠습니까?",
                    locationTitle: selected.structured_formatting.main_text,
                    locationSubtitle: "\(selected.structured_formatting.secondary_text)의 수도",
                    primaryButtonTitle: "추가하기",
                    secondaryButtonTitle: "취소",
                    primaryAction: {
                        Task {
                            let success = await viewModel.postTripPlaces()
                            
                            if success {
                                showAddModal = false
                                showCompleteModal = true
                            } else {
                                showAddModal = false
                                showErrorModal = true
                            }
                        }
                    },
                    secondaryAction: {
                        print("취소됨")
                        showAddModal = false
                    }
                )
            }
            
            if showCompleteModal, let selected = viewModel.selected {
                CustomModalView2(
                    title: "'내 여행지'에 추가되었습니다.",
                    locationTitle: selected.structured_formatting.main_text,
                    locationSubtitle: "\(selected.structured_formatting.secondary_text)의 수도",
                    primaryButtonTitle: "닫기",
                    primaryAction: {
                        print("닫기 완료")
                        showCompleteModal = false
                    }
                )
            }
        }
        .alert("해당 검색어로 조회된 결과가 존재하지 않습니다.", isPresented: $viewModel.showNoResultsAlert) {
            Button("확인", role: .cancel) { }
        }
        .alert("에러가 발생했습니다. 다시 시도해주세요.", isPresented: $showErrorModal) {
            Button("확인", role: .cancel) { }
        .onAppear {
            if !viewModel.keyword.isEmpty {
                Task { await viewModel.getPlaceSearch() }
            }
        }
    }
        
        private var searchBar: some View {
            ZStack(alignment: .top) {
                TextField("도시 이름을 입력하세요.", text: $viewModel.keyword)
                    .font(.customPretend(.medium, size: 14))
                    .foregroundStyle(.gray0001)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    .padding(.leading, 45)
                    .padding(.trailing, 35)
                    .padding(.vertical, 13)
                    .focused($focusedField)
                    .onSubmit {
                        Task {
                            await viewModel.getPlaceSearch()
                        }
                    }
                    .background(alignment: .bottom) {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.white)
                                .stroke(.gray0002, lineWidth: 1)
                            
                            HStack {
                                Image("search")
                                    .padding(.leading, 25)
                                    .frame(width: 24, height: 24)
                                
                                Spacer()
                                
                                if (focusedField) {
                                    Image("x_fill")
                                        .padding(.trailing, 30)
                                        .frame(width: 14, height: 14)
                                        .onTapGesture {
                                            viewModel.keyword.removeAll()
                                            viewModel.results = []
                                        }
                                    
                                }
                            }
                        }
                    }
                }
        }
    }
    
    private var dropDownView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .fill(.white)
                .frame(height: 10)
            
            ForEach(viewModel.results ?? [], id: \.place_id) { result in
                Text("\(result.structured_formatting.main_text), \(result.structured_formatting.secondary_text)")
                    .font(.customPretend(.medium, size: 14))
                    .foregroundStyle(.navy01)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .onTapGesture {
                        Task {
                            await viewModel.getLocation(place_id: result.place_id)
                            viewModel.selected = result
                            viewModel.results = []
                        }
                    }
                
                Divider()
            }
            
        }
        
        private var dropDownView: some View {
            VStack(alignment: .leading, spacing: 0) {
                Rectangle()
                    .fill(.white)
                    .frame(height: 10)
                
                ForEach(viewModel.results ?? [], id: \.place_id) { result in
                    Text("\(result.structured_formatting.main_text), \(result.structured_formatting.secondary_text)")
                        .font(.customPretend(.medium, size: 14))
                        .foregroundStyle(.navy01)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                        .onTapGesture {
                            Task {
                                await viewModel.getLocation(place_id: result.place_id)
                                viewModel.results = []
                            }
                        }
                    
                    Divider()
                }
            }
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 4, x: 0, y: 4)
        }
        
        private var emptyStateView: some View {
            VStack(alignment: .center) {
                HStack {
                    Text("예 : 파리, 뉴욕")
                        .font(.customPretend(.regular, size: 11))
                        .foregroundStyle(.gray0003)
                    
                    Spacer()
                }
                .padding(.leading, 16)
                
                Spacer()
                
                Text("원하는 장소를 검색해보세요.")
                    .font(.customPretend(.regular, size: 15))
                    .foregroundStyle(.black)
                
                Spacer()
            }
            .padding(.top, 8)
        }
        
        private var mapView: some View {
            ZStack(alignment: .bottom) {
                Map(position: $viewModel.cameraPosition, scope: mapScope) {
                    if let coord = viewModel.annotations {
                        Marker("", coordinate: coord)
                    }
                }
            }
            .mask(
                RoundedRectangle(cornerRadius: 12)
            )
            
            localSearchBtn
        }
        .mapScope(mapScope)
    }
    
    private var localSearchBtn: some View {
        Button(action : {
            print("여행지 목록에 추가")
            showAddModal = true
        }) {
            HStack(spacing: 10) {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                
                localSearchBtn
            }
            .mapScope(mapScope)
        }
        
        private var localSearchBtn: some View {
            Button(action : {
                print("여행지 목록에 추가")
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .frame(width: 14, height: 14)
                    
                    Text("여행지 목록에 추가")
                        .font(.customPretend(.semiBold, size: 15))
                        .foregroundStyle(.white)
                }
                .background(
                    RoundedRectangle(cornerRadius: 90)
                        .fill(.navy01)
                        .frame(width: 216, height: 56)
                )
            }
            .offset(y: -70)
        }
        
    }


/*
#Preview {
    MapView()
        .environment(NavigationRouter())
}


*/
