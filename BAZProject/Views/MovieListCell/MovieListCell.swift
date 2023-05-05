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
    
    func setData(with movieInfo: MovieInfo) {
        lblTitle.text = movieInfo.title.firstCapitalized
        imgCover.showActivityIndicator()
        guard let posterPath = movieInfo.posterPath else { return }
        ResourcesManager().downloadImage(from: posterPath) {[weak self] image in
            if let image = image {
                self?.imgCover.hideActivityIndicator() 
                self?.imgCover.image = image
            }
        }
    }
    
    func showEmptyView() {
        lblTitle.text = "Sin coincidencias"
    }
}
