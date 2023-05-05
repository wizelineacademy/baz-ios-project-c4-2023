//
//  MediaTableViewCell.swift
//  BAZProject
//
//  Created by gescarcega on 01/05/23.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    
    @IBOutlet private(set) weak var posterImageView: UIImageView!
    @IBOutlet private(set) weak var decorImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var subtitleLabel: UILabel!
    @IBOutlet private(set) weak var ratingLabel: UILabel!
    
    func setCell(with model: MediaTableViewCellModel) {
        posterImageView.image = UIImage(named: model.defaultImage ?? "")
        if let imagePath = model.image {
            Task {
                posterImageView.image = try? await UIImage(endpoint: ImageEndpoint(path: imagePath))
            }
        }
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        subtitleLabel.superview?.isHidden = model.subtitle == nil
        if let subtitle = model.footNote {
            ratingLabel.text = subtitle
            if model.rated {
                decorImageView.image = UIImage(systemName: "star.fill")
                decorImageView.tintColor = .systemYellow
            } else {
                decorImageView.image = UIImage(systemName: "clock")
                decorImageView.tintColor = .systemGray
            }
        } else {
            ratingLabel.isHidden = true
            decorImageView.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView?.image = nil
    }
    
}
