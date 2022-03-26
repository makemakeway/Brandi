//
//  GridLayout.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/27.
//

import UIKit

extension UICollectionViewLayout {
    static func gridLayout() -> UICollectionViewLayout {
        let ratio = Constants.GridSize.itemWidthRatio
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(ratio),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let inset = Constants.GridSize.inset
        item.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                     leading: inset,
                                                     bottom: inset,
                                                     trailing: inset)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(ratio))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
}
