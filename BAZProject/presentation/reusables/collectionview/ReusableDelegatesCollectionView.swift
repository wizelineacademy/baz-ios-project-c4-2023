//
//  ReusableDelegatesCollectionView.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation
import UIKit

class ReusableCollectionViewDataSource<T: ReusableCollectionViewCell<U>, U>: NSObject, UICollectionViewDataSource {
    
    // MARK: - Variables

    var items: [U] = []
    var message = ""
    var section = 1
    
    func updateItems(_ items: [U]) {
        self.items = items
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if items.count == 0{
            collectionView.setEmptyMessage(message)
        }else{
            collectionView.restore()
        }
        return items.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return section
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = NSStringFromClass(T.self)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else { return UICollectionViewCell() }
        cell.item = items[indexPath.row]
        return cell
    }
}

class ReusableCollectionViewDelegateAndFlowLayout: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize, height: collectionViewSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
}
