//
//  DetailReview.swift
//  BAZProject
//
//  Created by gescarcega on 06/05/23.
//

import Foundation

struct DetailReview: Hashable {
    
    var author: String?
    var content: String?
    var date: Date?
    
}

extension DetailReview {

    init(from dataObject: ReviewDataObject) {
        self.author = dataObject.author
        self.content = dataObject.content
        self.date = DateFormatter.getDate(from: dataObject.updatedAt ?? dataObject.createdAt, format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
    
}
