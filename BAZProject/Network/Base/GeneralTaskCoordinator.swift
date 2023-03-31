//
//  GeneralTaskCoordinator.swift
//  BAZProject
//
//  Created by bvelazquezva on 30/03/23.
//

import Foundation
//ServiceProtocols
protocol GeneralTaskCoordinatorProtocol{
    var session: URLSessionProtocol { get }
    var urlBase: String {get}
    var urlPath: String {get set}
    var apiURL: String {get}
    var apiKey: String {get}
    var urlRegion: String {get}
    func get<T: Decodable>(callback: @escaping (Result<T,Error>) -> Void)
}

extension GeneralTaskCoordinatorProtocol {
    var urlBase     : String {return "https://api.themoviedb.org/3/"}
    var apiURL      : String {return "?api_key="}
    var apiKey      : String {return "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"}
    var urlRegion   : String {return "&language=es&region=MX&page=1"}
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol { typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

//ServiceError
enum ServiceError: Error {
    case noData
    case response
    case parsingData
    case internalServer
}

//Services

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

extension URLSession: URLSessionProtocol {
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

class GeneralTaskCoordinator: GeneralTaskCoordinatorProtocol{
    
    var urlPath: String = ""
    
    var session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func get<T: Decodable>(callback: @escaping (Result<T,Error>) -> Void) {
        guard let url = URL(string: "\(urlBase)\(urlPath)\(apiURL)\(apiKey)\(urlRegion)") else {return}
        let finalURL = URLRequest(url: url)
        DispatchQueue.global().async {
            let task = self.session.performDataTask(with: finalURL) { (data, response, error) in

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
}
