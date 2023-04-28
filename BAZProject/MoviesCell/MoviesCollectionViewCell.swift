//
//  MoviesCollectionViewCell.swift
//  BAZProject
//
//  Created by ksolano on 20/04/23.
//

import UIKit

// Custom cell for show all movies in a Collection View
final class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = nil
        movieTitle.text = nil
    }

}
