//
//  SearchCollectionViewCell.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/27.
//

import UIKit

import Kingfisher
import SnapKit

final class SearchCollectionViewCell: UICollectionViewCell, ViewRepresentable {
    
    private let imageView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.contentMode = .scaleToFill
        view.backgroundColor = .gray
        view.layer.cornerRadius = Constants.GridSize.cornerRadius
        return view
    }()
    
    func setUp() {
        addSubview(imageView)

    }
    
    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(url: String) {
        imageView.kf.setImage(with: URL(string: url),
                              placeholder: UIImage(named: "placeholder"),
                              options: [])
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

