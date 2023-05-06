//
//  MovieDetailDataObject.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import Foundation

struct MovieDetailDataObject: Decodable, Equatable {
    
    var overview: String?
    var recommendations: GenericResponseDataObject?
    var reviews: ReviewCollectionDataOject?
    var similar: GenericResponseDataObject?
    var credits: CastDataObject?
    
}
