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

public class ImageTextTableViewCell: UITableViewCell {

    @IBOutlet public weak var lblTitle: UILabel!
    @IBOutlet public weak var lblOverView: UILabel!
    @IBOutlet public weak var imgPoster: UIImageView!
    private var downloadTask: URLSessionDownloadTask?
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
        lblTitle.text = ""
        imgPoster.image = UIImage(named: "poster")
    }
    
    public func setInfo(_ info: ImageTextTableViewProtocol) {
        lblTitle.text = info.strTitle
        lblOverView.text = info.strOverView
        if let url = info.urlConfiguration.configureURL() {
            downloadTask = imgPoster.loadImage(url: url)
        }
    }
}
