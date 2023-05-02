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
    
    private var movieInfo: MovieFoundInfo? {
        didSet {
            self.updateView()
        }
    }
    
    func setData(with movieInfo: MovieFoundInfo) {
        self.movieInfo = movieInfo
    }
    
    func updateView() {
        guard let movieInfo = self.movieInfo else { return }
        lblTitle.text = movieInfo.title.firstCapitalized
    }
}
