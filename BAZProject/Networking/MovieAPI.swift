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
class MovieAPI: Service{
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func getMovies<T:Decodable>(_ endpoint: Endpoint, callback: @escaping (Result<T, Error>) -> Void) {
        let request = endpoint.request
        DispatchQueue.global().async {
            let task = self.session.performDataTask(with: request) { (data, response, error) in
                guard let data: Data = data else { return callback(.failure(error ?? NSError())) }
                do {
                    let decodedData: T = try JSONDecoder().decode(T.self, from: data)
                    callback(.success(decodedData))
                } catch {
                    callback(.failure(error))
                }
            }
            task.resume()
        }
    }
    
}
