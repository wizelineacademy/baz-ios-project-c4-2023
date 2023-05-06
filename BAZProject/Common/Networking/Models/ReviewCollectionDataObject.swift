//
//  ReviewCollectionDataObject.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import Foundation

struct ReviewCollectionDataOject: Decodable, Equatable, Hashable {
    
    var reviews: Set<ReviewDataObject>?
    
    private enum CodingKeys: String, CodingKey {
        case reviews = "results"
    }
    
}

struct ReviewDataObject: Decodable, Equatable, Hashable {
    
    var author: String?
    var content: String?
    
}
