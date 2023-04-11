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
final class MovieAPI: Service{
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    /**
    This Function is generic, makes a request to a service,
    
    - Parameters:
       - endpoint: Is an enum that indicates what request it sends.
    
    - Returns:
       - T: return The type of the value to decode from the supplied JSON object.
       - Error: returns the service error
    */
    func getMovies<T:Decodable>(_ endpoint: OptionMovie, callback: @escaping (Result<T, Error>) -> Void) {
        let request = endpoint.request
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