//
//  Actor.swift
//  BAZProject
//
//  Created by jmgarciaca on 03/05/23.
//

import Foundation

/// A struct that represents the credits of a movie or TV show.
/// It contains the following properties:
/// - id:  An optional integer that represents the unique identifier of the credits.
/// - cast: The list of actors involved in the credits.
struct Credits : Codable {
    let id : Int?
    let cast : [Actor]
}

/// A struct representing an actor in a movie.
/// It contains the following properties:
/// - id: An optional integer that represents the unique ID of the actor.
/// - adult: An optional bool that represents if the actor is an adult.
/// - gender: An optional integer that represents the gender of the actor. 1 is female, 2 is male, and 0 is unspecified.
/// - known_for_department: An optional string that represents the department in which the actor is known for.
/// - name: An optional string that represents the name of the actor.
/// - original_name: An optional string that represents the original name of the actor.
/// - popularity: An optional double that represents the popularity score of the actor.
/// - profile_path: An optional string that represents the path to the actor's profile picture.
/// - cast_id: An optional integer that represents the ID of the actor's cast.
/// - character: An optional string that represents the character that the actor played in a movie.
/// - credit_id: An optional integer that represents the unique ID of the actor's credit.
/// - order: An optional integer that represents the order in which the actor appears in the credits.
struct Actor : Codable {
    let id : Int?
    let adult : Bool?
    let gender : Int?
    let known_for_department : String?
    let name : String?
    let original_name : String?
    let popularity : Double?
    let profile_path : String?
    let cast_id : Int?
    let character : String?
    let credit_id : String?
    let order : Int?
}
