//
//  Constants.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/27.
//

import UIKit

struct Constants {
    struct GridSize {
        static let padding: CGFloat = 12
        static let inset: CGFloat = 2
        static let itemWidthRatio: CGFloat = 1/3
        static let cornerRadius: CGFloat = 8
    }
    
    struct Network {
        static let url: String = "https://dapi.kakao.com/v2/search/image"
        static let header: String = "Authorization"
    }
    
    struct Page {
        static let size: Int = 30
    }
}
