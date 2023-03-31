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
    var urlPath: String {get set}
    func get<T: Decodable>(callback: @escaping (Result<T,Error>) -> Void)
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
    var session: URLSessionProtocol
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let urlBase: String = "https://api.themoviedb.org/3/"
    public var urlPath: String = ""
    private var apiURL: String = "?api_key="
    public var urlRegion: String = "&language=es&region=MX&page=1"
    
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
                    //let result = try? JSONSerialization.jsonObject(with: data) as? NSDictionary
                    //print(result)
                    let decodedData: T = try JSONDecoder().decode(T.self, from: data)
                    
                    //let results = decodedData.object(forKey: "results") as? [NSDictionary]
                    callback(.success(decodedData))
                } catch {
                    callback(.failure(ServiceError.parsingData))
                }
            }
            task.resume()
        }
        
    }

//    func get(url completion: @escaping ([Movie]) -> Void) {
//        guard let url = URL(string: "\(urlBase)\(urlPath)\(apiURL)\(apiKey)\(urlRegion)")
//        else {
//            return completion([])
//        }
//
//        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
//            var movies: [Movie] = []
//            defer {
//                completion(movies)
//            }
//            guard let data = data,
//                  let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
//                  let results = json.object(forKey: "results") as? [NSDictionary]
//            else { return }
//
//            for result in results {
//                if let id = result.object(forKey: "id") as? Int,
//                   let title = result.object(forKey: "title") as? String,
//                   let poster_path = result.object(forKey: "poster_path") as? String {
//                    movies.append(Movie(id: id, title: title, poster_path: poster_path))
//                }
//            }
//        }.resume()
//    }
}
