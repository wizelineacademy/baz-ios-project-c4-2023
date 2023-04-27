//
//  RequestSessionMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 30/03/23.
//

import Foundation

import Foundation
@testable import BAZProject

class RequestSessionMock: RequestSessionProtocol {
    
    var urlResponse = HTTPURLResponse(url: URL(string: "file://")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return (Data(), urlResponse)
    }
}
