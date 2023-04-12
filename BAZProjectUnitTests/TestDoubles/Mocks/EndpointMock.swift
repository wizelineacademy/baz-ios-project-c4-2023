//
//  EndpointsMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 30/03/23.
//

import Foundation
@testable import BAZProject

enum EndpointMock: EndpointProtocol {
    case forRequestFailure, forOtherTests
    
    var path: String {
        switch self {
        case .forOtherTests: return ""
        case .forRequestFailure: return "//"
        }
    }
    var scheme: String? { return nil }
    var key: String? { return nil }
    var host: String? { return nil }
}
