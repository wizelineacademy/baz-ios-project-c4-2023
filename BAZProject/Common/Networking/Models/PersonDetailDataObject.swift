//
//  PersonDetailDataObject.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import Foundation

struct PersonDetailDataObject: Decodable {
    
    var id: Int?
    var biography: String?
    var deathday: String?
    var birthday: String?
    var name: String?
    var profilePath: String?
    var combinedCredits: PersonCastingDataObject?
    
}

struct PersonCastingDataObject: Decodable, Equatable {
    
    var cast: Set<MediaDataObject>
    
}
