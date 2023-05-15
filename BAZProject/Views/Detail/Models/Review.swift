//
//  Review.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 28/04/23.
//

import Foundation

public struct Review: CellPersonalizedTableViewProtocol {
    var strReview: String?
    var strAuthor: String?
    
    public init(strReview: String? = nil, strAuthor: String? = nil) {
        self.strReview = strReview
        self.strAuthor = strAuthor
    }
    
    public var strTitle: String {
        return strAuthor ?? ""
    }
    public var strOverView: String? {
        return strReview
    }
    public var strDate: String?
    public var urlConfiguration: URLConfiguration?
}
