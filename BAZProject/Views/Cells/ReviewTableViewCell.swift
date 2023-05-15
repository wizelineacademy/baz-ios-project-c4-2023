//
//  ReviewTableViewCell.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 28/04/23.
//

import UIKit

public class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet public weak var lblReview: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        lblReview.text = ""
        lblAuthor.text = ""
    }
    
    func set(info review: CellPersonalizedTableViewProtocol){
        lblReview.text = review.strOverView
        lblAuthor.text = review.strTitle
    }
}
