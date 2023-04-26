//
//  URLSessionMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 28/03/23.
//

import XCTest
@testable import BAZProject

final class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    var expectation: XCTestExpectation?
    
    var dataTask = URLSessionDataTaskDummy()
    
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        completionHandler(data, urlResponse, error)
        expectation?.fulfill()
        return dataTask
    }
}

class URLSessionDataTaskDummy: URLSessionDataTaskProtocol {
    func resume() {}
}
