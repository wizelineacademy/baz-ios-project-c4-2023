//
//  MoviesCollectionViewCell.swift
//  BAZProject
//
//  Created by ksolano on 20/04/23.
//

import UIKit

// Custom cell for show all movies in a Collection View
final class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieFavButton: UIButton!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    var subscribeButtonAction : (() -> ())?

    var movieData: Movie? = nil
    var storeUserDefaults: MoviesStorageProtocol? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = nil
        movieTitle.text = nil
    }
    
    var titleLabel: String = "" {
        didSet{
            movieTitle.text = titleLabel
        }
    }
   
    var image: UIImage = UIImage() {
        didSet{
            movieImage.image = image
        }
    }
    
    @IBAction func favButton(_ sender: UIButton) {
        guard let movieFav = movieData else {
            return
        }
        subscribeButtonAction?()
    }
}
