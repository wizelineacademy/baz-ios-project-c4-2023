//
//  MovieCollectionViewCell.swift
//  BAZProject
//
//  Created by gescarcega on 26/04/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!

    func setCell(with model: MediaItem) {
        let fallBackPoster = model.mediaType?.defaultImage ?? ""
        posterImageView.image = UIImage(named: model.posterPath ?? fallBackPoster) ?? UIImage(named: fallBackPoster)
        titleLabel.text = model.title
        if let rating = model.rating {
            ratingLabel.text = "\(rating)"
            ratingLabel.superview?.isHidden = false
        } else {
            ratingLabel.superview?.isHidden = true
        }
    }
    
}


