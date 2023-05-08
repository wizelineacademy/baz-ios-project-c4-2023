//
//  MovieCollectionViewCell.swift
//  BAZProject
//
//  Created by gescarcega on 26/04/23.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var subtitleLabel: UILabel!
    @IBOutlet private(set) weak var decorImageView: UIImageView!
    
    func setCell(with model: MediaCollectionViewCellModel) {
        imageView.image = UIImage(named: model.defaultImage ?? "")
        if let imagePath = model.image {
            Task {
                imageView.image = try? await UIImage(endpoint: ImageEndpoint(path: imagePath))
            }
        }
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
            subtitleLabel.isHidden = true
            decorImageView.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}


