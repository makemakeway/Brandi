//
//  SearchView.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/27.
//

import UIKit

import SnapKit

final class SearchView: UIView, ViewRepresentable {
    
    let collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                                    collectionViewLayout: UICollectionViewLayout.gridLayout())
    
    let searchBar = UISearchBar()
    
    func searchBarConfig() {
        searchBar.placeholder = "검색"
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.tintColor = .black
    }
    
    func collectionViewConfig() {
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.keyboardDismissMode = .onDrag
    }
    
    func setUp() {
        self.backgroundColor = .white
        addSubview(collectionView)
        collectionViewConfig()
        searchBarConfig()
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
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
