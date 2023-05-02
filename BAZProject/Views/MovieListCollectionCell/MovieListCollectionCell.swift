//
//  MovieListCollectionCell.swift
//  BAZProject
//
//  Created by Carlos Garcia on 19/04/23.
//

import UIKit

class MovieListCollectionCell: UICollectionViewCell, ReusableCell {
    
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var imgCover: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func updateView(with movieInfo: MovieInfo) {
        lblTitle.text = movieInfo.title
        ResourcesManager().downloadImage(from: movieInfo.posterPath) { image in
            if let image = image {
                self.imgCover.image = image
            } else {
                self.imgCover.image = UIImage(named: "poster")
            }
        }
    }
}
