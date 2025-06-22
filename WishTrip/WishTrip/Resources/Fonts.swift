//
//  Font.swift
//  WishTrip
//
//  Created by 주민영 on 6/22/25.
//

import SwiftUI

extension Font {
    enum Pretend {
        case extraBold
        case bold
        case semiBold
        case medium
        case regular
        case light
        
        var value: String {
            switch self {
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .semiBold:
                return "Pretendard-SemiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .light:
                return "Pretendard-Light"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static func customPretend(_ type: Pretend, size: CGFloat) -> Font {
            return .custom(type.value, size: size)
    }
}
