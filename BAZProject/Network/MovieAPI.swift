//
//  MovieAPI.swift
//  BAZProject
//
//


import Foundation

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
extension URLSession: URLSessionProtocol {
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

class MovieAPI: Service {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func getMovies<T:Decodable>(_ endpoint: Endpoint, callback: @escaping (Result<T, Error>) -> Void) {
        let request = endpoint.request
        DispatchQueue.global().async {
            let task = self.session.performDataTask(with: request) { (data, response, error) in
                
                if let error: Error = error {
                    callback(.failure(error))
                    return
                }
                
                guard let data: Data = data else {
                    return callback(.failure(ServiceError.noData))
                }
                
                guard let response: HTTPURLResponse = response as? HTTPURLResponse else {
                    callback(.failure(ServiceError.response))
                    return
                }
                
                guard (200 ... 299) ~= response.statusCode else {
                    print("statusCode debe ser 2xx, pero es \(response.statusCode)")
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
}
