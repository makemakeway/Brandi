//
//  GridLayout.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/27.
//

import UIKit

extension UICollectionViewLayout {
    static func gridLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(Constants.GridSize.itemWidth),
            heightDimension: .absolute(Constants.GridSize.itemWidth)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(Constants.GridSize.itemWidth)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(Constants.GridSize.itemSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: Constants.GridSize.padding,
                                                        leading: Constants.GridSize.padding,
                                                        bottom: Constants.GridSize.padding,
                                                        trailing: Constants.GridSize.padding)
        section.interGroupSpacing = Constants.GridSize.itemSpacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
