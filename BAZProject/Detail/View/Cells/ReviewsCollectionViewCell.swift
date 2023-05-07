//
//  ReviewsCollectionViewCell.swift
//  BAZProject
//
//  Created by Ben Frank V. on 06/05/23.
//

import UIKit

class ReviewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var uvContent: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lycImage: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func septup(_ review: MovieReviews){
        uvContent.layer.cornerRadius = 8
        if let path = review.author_details.avatar_path{
            getUserImage(path)
        }else{
            lycImage.constant = 0
        }
        lblName.text = review.author_details.name
        lblUsername.text = review.author_details.username
        lblReview.text = review.content
    }
    
    func getUserImage(_ path: String){
        GetImage.getImage(pathPoster: path) { image in
            DispatchQueue.main.async { [weak self] in
                if let poster = image {
                    self?.imgUser.image = poster
                }
                
            }
            
        }
    }

}
