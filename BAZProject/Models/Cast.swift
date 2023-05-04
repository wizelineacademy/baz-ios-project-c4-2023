//
//  Cast.swift
//  BAZProject
//
//  Created by Manuel S on 27/04/23.
//

import Foundation

//MARK: - Protocolos para Actores
protocol CastInfoProtocol {
    var id: Int? { get set }
    var name: String? { get set }
    var profile_path: String? { get set }
    var character: String? { get set }
}
// Estructura para parsear los actores
struct Cast: Decodable, CastInfoProtocol {
    var id: Int?
    var name: String?
    var profile_path: String?
    var character: String?
}

struct Casts: Decodable {
    var cast: [Cast]?
}
