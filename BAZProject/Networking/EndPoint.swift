//
//  EndPoint.swift
//  BAZProject
//
//  Created by nmorenoa on 29/03/23.
//

import Foundation

protocol Endpoint{
    var baseURL         : String        { get }
    var path            : String        { get }
    var request         : URLRequest    { get }
    var url             : URLComponents?{ get }
}
extension Endpoint{
    
    var baseURL: String {
        return "https://api.themoviedb.org"
    }
    
    var apiKey: URLQueryItem {
        return URLQueryItem(name: "api_key",
                            value: "f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
    }
    
}
