//
//  DetailsCollectionViewCell.swift
//  BAZProject
//
//  Created by Manuel S on 27/04/23.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtLabel: UILabel!
    private var downloadTask: URLSessionDownloadTask?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setSimilarInfo(_ info: DetailsProtocol, indexPath: IndexPath) {
        txtLabel.text = info.getSimilarMoviesTitle(index: indexPath.row)
        downloadTask = imageView.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(info.getSimilarPath(index:indexPath.row) ?? "")")!)
    }
    
    func setRecommendationInfo(_ info: DetailsProtocol, indexPath: IndexPath) {
        txtLabel.text = info.getRecommendationMoviesTitle(index: indexPath.row)
        downloadTask = imageView.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(info.getRecommendationPath(index:indexPath.row) ?? "")")!)
    }
}
