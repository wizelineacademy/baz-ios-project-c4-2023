//
//  RequestHandlerMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import Foundation
import BAZProject

class RequestHandlerMock: RequestHandlerProtocol {
    
    var urlSession: RequestSessionProtocol
    
    init(urlSession: RequestSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func get(_ endpoint: EndpointProtocol) async throws -> Data {
        let (data, _) = try! await  urlSession.data(for: endpoint.getRequest()!)
        return data
    }
    
}
