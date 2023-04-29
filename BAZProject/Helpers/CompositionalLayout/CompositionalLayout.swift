//
//  CompositionalLayout.swift
//  BAZProject
//
//  Created by 989438 on 25/04/23.
//

import UIKit

enum CompositionalGroupAlignment {
    case vertical
    case horizontal
}

struct CompositionalLayout {
    static func createItem(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension, topSpacing: CGFloat = 0, bottomSpacing: CGFloat = 0, leadingSpacing: CGFloat = 0, trailingSpacing: CGFloat = 0) -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height))
        item.contentInsets = NSDirectionalEdgeInsets(top: topSpacing, leading: leadingSpacing, bottom: bottomSpacing, trailing: trailingSpacing)
        
        return item
    }
    
    static func createGroup(alignment: CompositionalGroupAlignment, width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension, items: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
        switch alignment {
        case .vertical:
            return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitems: items)
        case .horizontal:
            return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitems: items)
        }
    }
}
