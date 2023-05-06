//
//  MovieDetailDataObject.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import Foundation

struct MovieDetailDataObject: Decodable, Equatable {
    
    var id: Int?
    var title: String?
    var originalTitle: String?
    var overview: String?
    var posterPath: String?
    var voteAverage: Float?
    var recommendations: GenericResponseDataObject?
    var reviews: ReviewCollectionDataOject?
    var similar: GenericResponseDataObject?
    var credits: CastDataObject?
}
