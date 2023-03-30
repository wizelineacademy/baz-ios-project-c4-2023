//
//  RequestHandlerError.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import Foundation

enum RequestHandlerError: LocalizedError {
    case requestBuilder, nullData, serviceError(NSError)
    
    var errorDescription: String? {
        switch self {
        case .requestBuilder: return NSLocalizedString("Could not build request from provided URL", comment: "Request Error")
        case .nullData: return NSLocalizedString("Received data is nil", comment: "No Data Received")
        case .serviceError(let error): return error.localizedDescription
        }
    }
}
