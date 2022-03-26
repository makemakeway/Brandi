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
        static let itemSpacing: CGFloat = 8
        static let itemWidth: CGFloat = (UIScreen.main.bounds.width - CGFloat(padding * 2) - CGFloat(itemSpacing * 2)) / 3
    }
}
