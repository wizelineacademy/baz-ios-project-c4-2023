//
//  ReviewCollectionCell.swift
//  BAZProject
//
//  Created by 989438 on 28/04/23.
//

import UIKit

final class ReviewCollectionCell: UICollectionViewCell, ReusableIdentifierProtocol {
    @IBOutlet weak var raitingLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userReviewTextView: UITextView!
    
    func setup(review: ReviewModel) {
        if review.rating > 0 {
            raitingLabel.text = "\(review.rating)/10"
        } else {
            raitingLabel.text = "No raiting"
        }
        if let img = review.avatar {
            userImage.image = UIImage(data: img)
        } else {
            userImage.image = UIImage(named: "poster")
        }
        username.text = review.name
        userReviewTextView.text = review.content
    }
}
