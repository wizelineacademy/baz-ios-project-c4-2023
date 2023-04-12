//
//  HTTPTask.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 11/04/23.
//

import Foundation

public typealias HTTPHeaders = [ String : String ]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
    // TODO: (SDA) We can add more cases in order to have more requests types
}
