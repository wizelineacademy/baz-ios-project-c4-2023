//
//  Actor.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation

/*struct Actor {
    let id: Int
    let name: String
    let profile_path: String
    let character: String
}*/

struct ActorResponse: Codable {
    let cast: [Actor]
}

struct Actor: Codable{
    let name: String
    let profilePath: String?
    let character: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case character
    }
}
