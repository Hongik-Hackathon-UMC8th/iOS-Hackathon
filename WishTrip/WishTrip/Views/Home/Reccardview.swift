//
//  Reccardview.swift
//  WishTrip
//
//  Created by 김지우 on 6/22/25.
//

import SwiftUI

struct Reccardview: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .frame(width: 160, height: 200)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.navy01)
                .frame(width: 65, height: 30)
                .offset(x:-55,y:-95)
                
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
}


#Preview {
    Reccardview()
}
