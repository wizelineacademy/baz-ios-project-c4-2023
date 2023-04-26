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
    @IBOutlet private weak var categoryLabel: UILabel!

    func setCell(with model: MovieCollectionViewCellModel) {
        posterImageView.image = UIImage(named: model.posterName ?? "poster") ?? UIImage(named: "poster")
        titleLabel.text = model.title
        ratingLabel.text = model.rating
        categoryLabel.text = model.category
    }
    
}


