//
//  URLSessionMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 04/04/23.
//

import XCTest

@testable import BAZProject

final class URLSessionMock : URLSessionProtocol {
    var data: Data?
    var urlREsponse: URLResponse?
    var error: Error?
    var expected: XCTestExpectation?
    
    var dataTask = URLSessionDataTaskMock()
    
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        completionHandler(data, urlREsponse , error)
        expected?.fulfill()
        return dataTask
    }
    
}

class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    func resume() {}
}
