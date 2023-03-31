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
    
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    
    func customDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskProtocol {
        completionHandler(data, urlResponse, error)
        return SessionDataTaskMock()
    }
}
