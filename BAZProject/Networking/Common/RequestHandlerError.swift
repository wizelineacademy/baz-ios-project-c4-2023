//
//  RequestHandlerError.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import Foundation

enum RequestHandlerError: LocalizedError {
    case requestBuilder, nullData, serviceError(NSError), parsing
}
