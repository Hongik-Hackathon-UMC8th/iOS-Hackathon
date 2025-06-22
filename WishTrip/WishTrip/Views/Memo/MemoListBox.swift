import SwiftUI

struct MemoListBox: View {
    @ObservedObject var viewModel: MemoViewModel
    @State private var showMemoModal = false    // ① 모달 상태

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // ─── 헤더 ─────────────────────────────
            HStack {
                Text("여행 기록")
                    .font(.custom("Pretendard-SemiBold", size: 15))
                Spacer()   // ← 텍스트와 버튼 사이를 띄워서 버튼이 우측에 붙도록

                Button {
                    print("메모 버튼 탭됨")   // 디버깅용
                    showMemoModal = true      // ② 상태 변경
                } label: {
                    Image("button3")          // 실제 Asset 이름으로 바꿔주세요
                        .resizable()
                        .frame(width: 21, height: 21)
                }
            }
            .padding(.horizontal, 15)

            Text("특별한 감정 기록하기")
                .font(.custom("Pretendard-Regular", size: 11))
                .foregroundColor(.gray01)
                .padding(.horizontal, 15)
            

            // ─── 최근 메모 한 개만 ────────────────────
            ForEach(viewModel.sortedMemos.prefix(1)) { memo in
                MemoCardView(memo: memo)
            }

            // ─── 더보기 링크 ─────────────────────────
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
        // ─── 여기에 반드시 sheet 붙이기 ───────────
        .sheet(isPresented: $showMemoModal) {
            MemoModal()
        }
    }
}
