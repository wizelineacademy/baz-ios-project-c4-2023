//
//  Cast.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 05/05/23.
//

import Foundation

/// Protocolo que desacopla la estructura de Cast
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
/// Estructura que contine la información que se usara en la vista
struct CastResult: Codable {
    var id: Int
    var cast, crew: [Cast]
}

// MARK: - Cast
/// Estructura de una el elecnco de una pélicula
struct Cast: Codable, CastProtocol{
    ///Identificador si es para adultos
    var adult: Bool
    ///Identificador del genero
    var gender: Int
    ///Identificador
    var id: Int
    
    var knownForDepartment: String
    ///Nombre del la persona del reparto
    var name: String
    ///Nombre original de la persona del reparto
    var originalName: String
    ///Popularidad de la persona de reparto
    var popularity: Double
    ///Imagen para identificar a la persona del reparto
    var profilePath: String?
    ///Identificador del Cast
    var castID: Int?
    ///Nombre del personaje que interpreta
    var character: String?
    ///Identificador  del credito
    var creditID: String
    ///orden de aparicion
    var order: Int?
    
    var department, job: String?
    ///Regresa el url del actor
    var urlProfilePath: URL? {
        return MovieDetailInfo.image(profilePath ?? "").imageUrl
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
