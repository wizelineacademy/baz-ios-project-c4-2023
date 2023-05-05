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
    
//    private var movieInfo: MovieFoundInfo? {
//        didSet {
//            self.updateView()
//        }
//    }
    
//    func setData(with movieInfo: MovieFoundInfo) {
//        self.movieInfo = movieInfo
//    }
    
    func setData(with movieInfo: MovieInfo) {
        lblTitle.text = "Película"
        lblTitle.text = movieInfo.title.firstCapitalized
        guard let posterPath = movieInfo.posterPath else { return }
        ResourcesManager().downloadImage(from: posterPath) { image in
            if let image = image {
                self.imgCover.image = image
            }
        }
    }
    
//    func updateView() {
//        guard let movieInfo = self.movieInfo else { return }
//        lblTitle.text = movieInfo.title.firstCapitalized
//    }
    
    func showEmptyView() {
        lblTitle.text = "Sin coincidencias"
    }
}
