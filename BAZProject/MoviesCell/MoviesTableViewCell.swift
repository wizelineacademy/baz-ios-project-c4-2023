//
//  MoviesTableViewCell.swift
//  BAZProject
//
//  Created by ksolano on 18/04/23.
//

import UIKit

// Custom cell for show all movies in a Table View
final class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!

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
        movieImage.image = nil
        movieTitleLabel.text = nil
    }
    
}
