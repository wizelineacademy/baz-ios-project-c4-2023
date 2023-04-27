//
//  ImageTextTableViewCell.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
//

import UIKit

public protocol ImageTextTableViewProtocol {
    var strTitle: String { get }
    var strOverView: String? { get }
    var strDate: String? { get }
    var urlConfiguration: URLConfiguration? { get }
}

public class ImageTextTableViewCell: UITableViewCell {
    @IBOutlet public weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOverView: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    private var downloadTask: URLSessionDownloadTask?
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
        lblTitle.text = ""
        lblDate.text = ""
        imgPoster.image = UIImage(named: "poster")
    }
    
    func setInfo(_ info: ImageTextTableViewProtocol, numberOfLines iNumber: Int = 2) {
        lblTitle.text = info.strTitle
        lblOverView.numberOfLines = iNumber
        lblOverView.text = info.strOverView
        lblDate.text = info.strDate
        if let urlConfiguration = info.urlConfiguration {
            downloadTask = imgPoster.loadImage(urlConfiguration: urlConfiguration)
        }
    }
}
