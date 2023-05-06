//
//  CastDataObject.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import Foundation

struct CastDataObject: Decodable, Equatable {
    
    var cast: Set<CastMemberDataObject>?
    
}

struct CastMemberDataObject: Decodable, Equatable, Hashable {
    
    var id: Int?
    var name: String?
    var profilePath: String?
    var character: String?
    var order: Int?
    
}
