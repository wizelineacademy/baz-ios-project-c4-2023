//
//  EndPointType.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 11/04/23.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
