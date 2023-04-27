//
//  MovieCollectionViewCell.swift
//  BAZProject
//
//  Created by gescarcega on 26/04/23.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var decorImageView: UIImageView!
    
    func setCell(with model: MediaCollectionViewCellModel) {
        imageView.image = UIImage(named: model.defaultImage ?? "")
        titleLabel.text = model.title
        if let subtitle = model.subtitle {
            subtitleLabel.text = subtitle
            if model.rated {
                decorImageView.image = UIImage(systemName: "star.fill")
                decorImageView.tintColor = .systemYellow
            } else {
                decorImageView.image = UIImage(systemName: "clock")
                decorImageView.tintColor = .systemGray
            }
        } else {
            subtitleLabel.superview?.isHidden = true
        }
    }
    
}


