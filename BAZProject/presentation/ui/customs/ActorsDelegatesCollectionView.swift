//
//  ActorsDelegatesCollectionView.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation
import UIKit

// MARK: - Class

class ActorsFlowLayout: ReusableCollectionViewDelegateAndFlowLayout {
        
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: .dim220)
    }
}
