//
//  UserReview.swift
//  BAZProject
//
//  Created by jmgarciaca on 04/05/23.
//

import UIKit

/// A custom UIView representing a user review.
class UserReview: UIView {
    
    /// The view model for the review.
    var reviewVM: ReviewViewModel?
    
    /// An instance of the `ImageLoader` used for loading the review's avatar image.
    private let imageLoader: ImageLoader = ImageLoader()
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txvReview: UITextView!
    
    /// Returns an instance of `UserReview`.
    /// - Parameter review: The `Review` object that the view represents.
    /// - Returns: An instance of `UserReview` if the nib could be loaded, otherwise `nil`.
    class func instanceFromNib(_ review: Review) -> UIView? {
        guard let nib = Bundle.main.loadNibNamed("UserReview", owner: self, options: nil)?.first as? UserReview  else { return nil }
        
        nib.setupComponent(review)
        return nib
    }
}

extension UserReview {
    
    /// Sets up the view with the given review data.
    /// - Parameter review: The `Review` object that the view represents.
    private func setupComponent(_ review: Review) {
        reviewVM = ReviewViewModel(review)
        
        lblTitle.text = reviewVM?.user_name
        txvReview.attributedText = reviewVM?.content
        
        if let url = URL(string: reviewVM?.avatar_path ?? "") {
            imageLoader.getImage(from: url) { [weak self] image in
                self?.imgView.image = image
            }
        }
    }
}
