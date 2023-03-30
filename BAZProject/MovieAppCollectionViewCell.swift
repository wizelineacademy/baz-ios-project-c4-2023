//
//  MovieAppCollectionViewCell.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 28/03/23.
//

import UIKit

class MovieAppCollectionViewCell: UICollectionViewCell {
    
    // MARK: UIElements
    
    @IBOutlet weak var cellBottomView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
    }

}
