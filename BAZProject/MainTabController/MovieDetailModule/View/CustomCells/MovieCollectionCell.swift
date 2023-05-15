//
//  MovieCollectionCell.swift
//  BAZProject
//
//  Created by 989438 on 25/04/23.
//

import UIKit

final class MovieCollectionCell: UICollectionViewCell, ReusableIdentifierProtocol {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterMovie: UIImageView!
    
    func setup(movieDetailModel: Movie) {
        movieTitle.text = movieDetailModel.title
        posterMovie.image = UIImage(data: movieDetailModel.posterPath)
    }
}
