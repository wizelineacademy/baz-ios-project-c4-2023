//
//  Cast.swift
//  BAZProject
//
//  Created by Manuel S on 27/04/23.
//

import Foundation

//MARK: - Protocolos para Actores

protocol CastProtocol {
    var id: Int? { get set }
    var name: String? { get set }
    var poster_path: String? { get set }
    var character: String? { get set }
}

// Estructura para parsear los actores
struct Cast: Decodable, CastProtocol {
    var id: Int?
    var name: String?
    var poster_path: String?
    var character: String?
}
