//
//  Cast.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 05/05/23.
//

import Foundation

protocol CastProtocol{
    var adult: Bool { get set }
    var gender: Int { get set }
    var id: Int { get set }
    var knownForDepartment: String { get set }
    var name: String { get set }
    var originalName: String { get set }
    var popularity: Double { get set }
    var profilePath: String? { get set }
    var castID: Int? { get set }
    var character: String? { get set }
    var creditID: String { get set }
    var order: Int? { get set }
    var department: String? { get set }
    var job: String? { get set }
    var urlProfilePath: URL? { get }
}

// MARK: - CastResult
struct CastResult: Codable {
    var id: Int
    var cast, crew: [Cast]
}

// MARK: - Cast
struct Cast: Codable, CastProtocol{
    
    var adult: Bool
    var gender, id: Int
    var knownForDepartment, name, originalName: String
    var popularity: Double
    var profilePath: String?
    var castID: Int?
    var character: String?
    var creditID: String
    var order: Int?
    var department, job: String?
    var urlProfilePath: URL? {
        return ApiConstans.image(profilePath ?? "").imageUrl
    }

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}
