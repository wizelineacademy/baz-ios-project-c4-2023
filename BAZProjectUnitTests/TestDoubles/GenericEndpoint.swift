//
//  GenericEndpoint.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

import Foundation
@testable import BAZProject

struct GenericEndpoint: EndpointProtocol {
    var path: String
    var scheme: String?
    var queries: [URLQueryItem]?
    var key: String?
    var host: String?
}
