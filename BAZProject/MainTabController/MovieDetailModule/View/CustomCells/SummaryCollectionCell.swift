//
//  SummaryCollectionCell.swift
//  BAZProject
//
//  Created by 989438 on 24/04/23.
//

import UIKit

final class SummaryCollectionCell: UICollectionViewCell, ReusableIdentifierProtocol {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    func setup(movieDetailModel: Movie) {
        if let img = movieDetailModel.backdropPathData {
            moviePoster.image = UIImage(data: img)
        }
        moviePoster.clipsToBounds = true
        moviePoster.contentMode = .scaleAspectFill
        summaryLabel.sizeToFit()
        summaryLabel.text = movieDetailModel.summary
    }
}
