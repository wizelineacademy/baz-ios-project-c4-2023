//
//  SearchTableViewCell.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var imageVire: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    private var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        downloadTask?.cancel()
        downloadTask = nil
        labelText.text = ""
        imageVire.image = UIImage(named: "poster")
    }
    
    func setInfo(_ info: SearchListProtocol, indexPath: IndexPath) {
        labelText.text = info.getTitle(index: indexPath.row)
        downloadTask = imageVire.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(info.getImagePath(index:indexPath.row) ?? "")")!)
    }
}
