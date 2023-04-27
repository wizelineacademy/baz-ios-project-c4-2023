//
//  customCell.swift
//  BAZProject
//
//  Created by Manuel S on 26/04/23.
//

import UIKit

class customCell: UITableViewCell {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    private var downloadTask: URLSessionDownloadTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
        titleLable.text = ""
        movieImage.image = UIImage(named: "poster")
    }
    
    ///Setea todos los datos para que la celda pueda 
    func setInfo(_ info: MoviesListProtocol, indexPath: IndexPath) {
        titleLable.text = info.getTitle(index: indexPath.row)
        downloadTask = movieImage.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(info.getPathImage(index:indexPath.row) ?? "")")!)
    }
}
