//
//  RequestHandlerError.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import Foundation

enum RequestHandlerError: LocalizedError, Equatable {
    case requestBuilder, badResponse
    
    var errorDescription: String? {
        switch self {
        case .requestBuilder: return NSLocalizedString("Could not build request from provided URL", comment: "Request Error")
        case .badResponse: return NSLocalizedString("HTTP Unexpected Response", comment: "")
        }
    }
}
