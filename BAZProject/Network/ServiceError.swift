//
//  ServiceError.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 04/04/23.
//

import Foundation

enum ServiceError: Error {
    case noData
    case response
    case parsingData
    case internalServer
}
