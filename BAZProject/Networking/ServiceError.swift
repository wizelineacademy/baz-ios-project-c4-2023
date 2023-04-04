//
//  ServiceError.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

enum ServiceError: Error {
    case noData
    case response
    case parsingData
    case internalServer
}
