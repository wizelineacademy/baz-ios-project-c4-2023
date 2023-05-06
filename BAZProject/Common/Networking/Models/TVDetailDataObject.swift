//
//  TVDetailDataObject.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import Foundation

struct TVDetailDataObject: Decodable {
    
    var id: Int?
    var name: String?
    var overview: String?
    var posterPath: String?
    var originalName: String?
    var voteAverage: Float?
    var status: String?
    var recommendations: GenericResponseDataObject?
    var similar: GenericResponseDataObject?
    var reviews: ReviewCollectionDataOject?
    var credits: CastDataObject?
    
}
