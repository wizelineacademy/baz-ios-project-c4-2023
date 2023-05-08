//
//  ServiceMocks.swift
//  BAZProjectTests
//
//  Created by Manuel S on 21/04/23.
//

import BAZProject
import Foundation

class SessionMock: URLSessionProtocol {
    
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> BAZProject.URLSessionDataTaskProtocol {
        completionHandler(data, urlResponse, error)
        return DataTaskMock()
    }
}

class DataTaskMock: URLSessionDataTaskProtocol {
    func resume() {}
}
