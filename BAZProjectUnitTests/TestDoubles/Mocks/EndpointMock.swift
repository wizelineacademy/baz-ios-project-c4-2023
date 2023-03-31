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
    
    var request: URLRequest? {
        switch self {
        case .forRequestFailure: return nil
        case .forOtherTests: return URLRequest(url: URL(string: "file://")!)
        }
    }
}
