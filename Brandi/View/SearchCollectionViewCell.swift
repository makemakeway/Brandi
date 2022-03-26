//
//  SearchCollectionViewCell.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/27.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell, ViewRepresentable {
    
    let imageView: UIImageView = UIImageView()
    
    func setUp() {
        
    }
    
    func setConstraints() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

