//
//  FavoriteTableViewCell.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    private var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        downloadTask?.cancel()
        downloadTask = nil
        labelText.text = ""
        photoView.image = UIImage(named: "poster")
    }
    
    func setInfo(_ info: FavoriteListProtocol, indexPath: IndexPath) {
        labelText.text = info.getTitle(index: indexPath.row)
        downloadTask = photoView.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(info.getPathImage(index:indexPath.row) ?? "")")!)
    }
}
