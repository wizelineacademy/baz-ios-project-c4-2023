//
//  ImageTextTableViewCell.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
//

import UIKit

public protocol ImageTextTableViewProtocol {
    var strTitle: String { get }
    var strOverView: String { get }
    var urlConfiguration: URLConfiguration { get }
}

class ImageTextTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverView: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    private var downloadTask: URLSessionDownloadTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
        lblTitle.text = ""
        imgPoster.image = UIImage(named: "poster")
    }
    
    func setInfo(_ info: ImageTextTableViewProtocol) {
        lblTitle.text = info.strTitle
        lblOverView.text = info.strOverView
        if let url = info.urlConfiguration.configureURL() {
            downloadTask = imgPoster.loadImage(url: url)
        }
    }
}
