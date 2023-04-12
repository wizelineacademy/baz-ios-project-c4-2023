//
//  MovieListCell.swift
//  BAZProject
//
//  Created by Carlos Garcia on 07/04/23.
//

import UIKit

class MovieListCell: UITableViewCell, ReusableCell {
    
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var imgCover: UIImageView!
    
    private var movieInfo: MovieInfo? {
        didSet {
            self.updateView()
        }
    }
    
    func setData(with movieInfo: MovieInfo) {
        self.movieInfo = movieInfo
    }
    
    func updateView() {
        guard let movieInfo = self.movieInfo else { return }
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
