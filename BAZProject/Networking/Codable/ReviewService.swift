//
//  ReviewService.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 28/04/23.
//

import Foundation

public struct ReviewService: Decodable {
    var author: String?
    var content: String
}

extension ReviewService {
    func converteToReviewApp() -> Review {
        return Review(strReview: content, strAuthor: author)
    }
}
