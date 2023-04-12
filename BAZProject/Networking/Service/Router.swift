//
//  Router.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 11/04/23.
//

import Foundation

class Router<EndPoint: EndPointType> :NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        
    }
    
    func cancel() {
        
    }
}
