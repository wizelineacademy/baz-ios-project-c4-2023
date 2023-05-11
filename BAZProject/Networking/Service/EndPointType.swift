//
//  EndPointType.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 11/04/23.
//

import Foundation

// TODO: (SDA) Maybe erase all the parts that we do not need for this project
protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get } // TODO: (SDA) Erase this
    var headers: HTTPHeaders? { get } // TODO: (SDA) Erase this
}
