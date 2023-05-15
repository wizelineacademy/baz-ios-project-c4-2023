//
//  InfoReviewTableViewCell.swift
//  BAZProject
//
//  Created by ksolano on 05/05/23.
//

import UIKit

class InfoReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        infoLabel.text = nil
        ratingLabel.text = nil
    }
    
    var infoLabelText: String = "" {
        didSet{
            infoLabel.text = infoLabelText
        }
    }
    var ratingLabelText: String = "" {
        didSet{
            ratingLabel.text = ratingLabelText
        }
    }
}
