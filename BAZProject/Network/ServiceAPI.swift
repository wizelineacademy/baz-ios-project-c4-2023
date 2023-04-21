//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class ServiceAPI: ServiceProtocol {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func get<T: Decodable>(_ endpoint: URL, callback: @escaping (Result<T,Error>) -> Void) {
        let request: URLRequest = URLRequest(url: endpoint)
        let task = session.performDataTask(with: request) { (data, response, error) in
            if let error: Error = error {
                callback(.failure(error))
                return
            }
            
            guard let data: Data = data else {
                callback(.failure(ServiceError.noData))
                return
            }
            
            guard let response: HTTPURLResponse = response as? HTTPURLResponse else {
                callback(.failure(ServiceError.response))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                callback(.failure(ServiceError.internalServer))
                return
            }
            
            do {
                let decodedData: T = try JSONDecoder().decode(T.self, from: data)
                callback(.success(decodedData))
            } catch {
                callback(.failure(ServiceError.parsingData))
            }
        }
        task.resume()
    }
}
