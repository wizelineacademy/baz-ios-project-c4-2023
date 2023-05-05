//
//  MovieListCollectionCell.swift
//  BAZProject
//
//  Created by Carlos Garcia on 19/04/23.
//

import UIKit

class MovieListCollectionCell: UICollectionViewCell, ReusableCell {
    
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var imgCover: UIImageView! {
        didSet {
            self.imgCover.image = UIImage(named: "poster")
        }
    }
    
    public func updateView(with movieInfo: MovieInfo) {
        lblTitle.text = movieInfo.title
        imgCover.showActivityIndicator()
        guard let posterPath = movieInfo.posterPath else { return }
        ResourcesManager().downloadImage(from: posterPath) {[weak self] image in
            if let image = image {
                self?.imgCover.hideActivityIndicator()
                self?.imgCover.image = image
            }
        }
    }
}
