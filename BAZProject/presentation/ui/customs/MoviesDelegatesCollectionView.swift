//
//  ReusableCollectionView.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 29/03/23.
//

import Foundation
import UIKit

// MARK: - Class
class MoviesDataSource: ReusableCollectionViewDataSource<MovieItemAdapter, Movie> { }

class MoviesFlowLayout: ReusableCollectionViewDelegateAndFlowLayout {

    weak var viewController: UIViewController?

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: .dim220)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = (collectionView.dataSource as? MoviesDataSource)?.items[indexPath.row] {
            let movieDetailVC = MovieViewController(movie: movie)
            viewController?.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
}
