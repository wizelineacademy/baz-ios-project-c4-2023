//
//  TVDetailDataObject.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import Foundation

struct TVDetailDataObject: Decodable {
    
    var overview: String?
    var status: String?
    var first_air_date: String?
    var last_air_date: String?
    var recommendations: GenericResponseDataObject?
    var similar: GenericResponseDataObject?
    var reviews: ReviewCollectionDataOject?
    var credits: CastDataObject?
    
}
