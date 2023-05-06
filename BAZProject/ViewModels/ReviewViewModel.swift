//
//  ReviewViewModel.swift
//  BAZProject
//
//  Created by jmgarciaca on 04/05/23.
//

import Foundation

/// A view model for representing a review.
struct ReviewViewModel {
    
    /// The review object that this view model is representing.
    var revirew: Review
    
    /// Initializes a new instance of `ReviewViewModel`.
    /// - Parameters:
    ///    - review: The `Review` object to be represented by the view model.
    init(_ revirew: Review) {
        self.revirew = revirew
    }
}

extension ReviewViewModel {
    
    /// The path to the avatar image of the user who wrote the review.
    /// If the path is `nil`, returns an empty string.
    var avatar_path: String {
        revirew.author_details.avatar_path ?? ""
    }
    
    /// The name of the user who wrote the review.
    /// If the username is `nil`, returns an empty string.
    var user_name: String {
        revirew.author_details.username ?? ""
    }
    
    /// The content of the review as an attributed string.
    /// If the content is `nil`, returns an empty attributed string.
    var content: NSAttributedString {
        revirew.content?.htmlToAttributedString ?? NSAttributedString(string: "")
    }
}
