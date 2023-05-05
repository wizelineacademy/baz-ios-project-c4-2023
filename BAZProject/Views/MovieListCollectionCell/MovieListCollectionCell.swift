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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func updateView(with movieInfo: MovieInfo) {
        lblTitle.text = movieInfo.title
        guard let posterPath = movieInfo.posterPath else { return }
        ResourcesManager().downloadImage(from: posterPath) { image in
            if let image = image {
                self.imgCover.image = image
            }
        }
    }
}
