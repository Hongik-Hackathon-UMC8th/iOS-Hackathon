//
//  MemoMain.swift
//  WishTrip
//
//  Created by 신민정 on 6/22/25.
//
import SwiftUI
struct MemoMain: View {
    @StateObject private var viewModel2 = MemoVM2()
    @StateObject private var viewModel = MemoViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.memomain.ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer().frame(height:6.5)
                Text("기록")
                        .font(.custom("Pretendard-SemiBold", size: 16))
                    SearchBarSection()
                    TravelListBox(viewModel2: viewModel2)
                    MemoListBox(viewModel: viewModel)
                    Spacer()
                }
                
            }
            .navigationBarHidden(true)
        }
    }
}



struct SearchBarSection: View {
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.memomain)
                    .frame(width: 350, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                HStack(spacing: 10) {
                    Image("search")
                        .resizable()
                        .frame(width: 20, height: 20)

                    Text("도시 이름을 입력하세요.")
                        .font(.custom("Pretendard-Regular", size: 14))
                        .foregroundColor(.searchcolor)
                      
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 40)
            }

            Text("예 : 파리, 뉴욕")
                .font(.caption)
                .foregroundColor(.searchcolor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
        }
    }
}

struct TravelListBox: View {
    @ObservedObject var viewModel2: MemoVM2

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading){
                Text("여행지 목록")
                    .font(.headline)
                Text("추가한 여행지")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal,15)
            

            ForEach(viewModel2.destinations.prefix(2)) { dest in
                DestinationRow(destination: dest)
            }


            NavigationLink {

                FullListView(viewModel2: viewModel2)
            } label: {
                Text("더보기")
                    .font(.body)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.15), radius: 5)
        .padding(.horizontal)
    }
}



struct DestinationRow: View {
    let destination: Destination

    var body: some View {
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
                HStack{
                    Button { } label: {
                        Image("button1")
                            .resizable()
                            .frame(width: 19.45, height: 19.45)
                    }
                    Spacer()
                        .frame(width:17)
                    Button {  } label: {
                        Image("button2")
                            .resizable()
                            .frame(width: 21, height: 21)
                    }
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
    MemoMain()
}
