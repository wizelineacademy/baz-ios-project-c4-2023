//
//  DetailsCollectionViewCell.swift
//  BAZProject
//
//  Created by Manuel S on 27/04/23.
//

import UIKit

final class DetailsCollectionViewCell: UICollectionViewCell {
   
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    private var downloadTask: URLSessionDownloadTask?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        downloadTask?.cancel()
        downloadTask = nil
        txtLabel.text = ""
        characterLabel.text = ""
        imageView.image = UIImage(named: "poster")
    }
    
    ///Funcion para setear imagenes y titulos
    func setInfo(_ info: DetailsProtocol, indexPath: IndexPath, type: CategoriesFilter) {
        switch type {
        case .similar:
            txtLabel.text = info.getSimilarMoviesTitle(index: indexPath.row)
            downloadTask = imageView.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(info.getSimilarPath(index:indexPath.row) ?? "")")!)
        case .recommendation:
            txtLabel.text = info.getRecommendationMoviesTitle(index: indexPath.row)
            downloadTask = imageView.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(info.getRecommendationPath(index:indexPath.row) ?? "")")!)
        case .cast:
            txtLabel.text = info.getCastMovieTitle(index: indexPath.row)
            downloadTask = imageView.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(info.getCastPath(index:indexPath.row) ?? "")")!)
            characterLabel.text = info.getCastMovieMoviesCharacter(index: indexPath.row)
        default:
            txtLabel.text = info.getTitle()
            downloadTask = imageView.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(info.getPathImage() ?? "")")!)
        }
    }
}
