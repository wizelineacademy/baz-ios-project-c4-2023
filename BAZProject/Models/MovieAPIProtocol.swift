//
//  MovieAPIProtocol.swift
//  BAZProject
//
//  Created by ksolano on 24/04/23.
//

import Foundation

protocol MovieAPIProtocol {
    var basePath: String  { get }

    var apiKey: String { get }
    func fetch<T: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
    func decode<T: Decodable>(data: Data, jsonDecoder: JSONDecoder) -> T?
}
