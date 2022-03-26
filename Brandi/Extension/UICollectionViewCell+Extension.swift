//
//  UICollectionViewCell+Extension.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/27.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
