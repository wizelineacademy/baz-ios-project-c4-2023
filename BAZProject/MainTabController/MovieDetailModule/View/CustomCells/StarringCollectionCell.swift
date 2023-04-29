//
//  StarringCollectionCell.swift
//  BAZProject
//
//  Created by 989438 on 25/04/23.
//

import UIKit

final class StarringCollectionCell: UICollectionViewCell, ReusableIdentifierProtocol {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starringImage: UIImageView!
    
    func setup(movieDetailModel: ActorModel) {
        if let img = movieDetailModel.profileImage {
            starringImage.image = UIImage(data: img)
        }
        starringImage.layoutIfNeeded()
        starringImage.layer.cornerRadius = starringImage.frame.height / 2
        nameLabel.text = movieDetailModel.name
    }
}
