//
//  ImageTextTableViewCell.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
//

import UIKit

class ImageTextTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.text = ""
        imgPoster.image = UIImage(named: "poster")
    }
    
    
    func set(title strTitle: String, andImage strUrl: String) {
        lblTitle.text = strTitle
    }
}
