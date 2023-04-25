//
//  HTTPTask.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 11/04/23.
//

import Foundation

public typealias HTTPHeaders = [ String : String ]

// TODO: (SDA) Maybe we can erase this file since our request will not include parameters, or maybe they will, we'll see...
/// This HTTPTask is responsible for configuring parameters for a specific endPoint. In this case we are including a simple request, a request with parameters and another request with parameters and headers
public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
                           bodyEncoding: ParameterEncoding,
                           urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders?)
    // TODO: (SDA) We can add more cases in order to have more requests types (download, upload, etc)
}
