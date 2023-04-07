//
//  MovieListCell.swift
//  BAZProject
//
//  Created by Carlos Garcia on 07/04/23.
//

import UIKit

class MovieListCell: UITableViewCell, ReusableCell {
    func setData(with movieInfo: MovieInfo) {
        var config = UIListContentConfiguration.cell()
        config.text = movieInfo.title
        ResourcesManager().downloadImage(from: movieInfo.posterPath) { image in
            if let image = image {
                config.image = image
            } else {
                config.image = UIImage(named: "poster")
            }
            self.contentConfiguration = config
        }
        
    }
}
