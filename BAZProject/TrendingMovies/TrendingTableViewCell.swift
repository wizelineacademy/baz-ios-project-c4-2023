//
//  TrendingTableViewCell.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {

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
    ///Setea todos los datos para la celda
    func setInfo(_ info: TrendingListProtocol, indexPath: IndexPath) {
        titleLable.text = info.getTitle(index: indexPath.row)
        downloadTask = movieImage.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(info.getPathImage(index:indexPath.row) ?? "")")!)
    }
}
