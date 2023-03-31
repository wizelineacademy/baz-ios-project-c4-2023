//
//  URLSessionMock.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 31/03/23.
//

import XCTest
@testable import BAZProject

final class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    var expectation: XCTestExpectation?
    
    var dataTask = URLSessionDataTaskMock()
    
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        completionHandler(data, urlResponse, error)
        return dataTask
    }
}
class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    func resume() {}
}
