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
    
    func getMovies(_ endpoint: Endpoint, callback: @escaping (Result<[Movie], Error>) -> Void) {
        let request = endpoint.request
        DispatchQueue.global().async {
            let task = self.session.performDataTask(with: request) { (data, response, error) in
                var movies: [Movie] = []
                do {
                    guard let data = data,
                          let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                          let results = json.object(forKey: "results") as? [NSDictionary]
                    else { return }

                    for result in results {
                        if let id = result.object(forKey: "id") as? Int,
                           let title = result.object(forKey: "title") as? String,
                           let poster_path = result.object(forKey: "poster_path") as? String {
                            movies.append(Movie(id: id, title: title, poster_path: poster_path))
                        }
                    }
                    callback(.success(movies))
                } catch {
                    callback(.failure(error))
                }
            }
            task.resume()
        }
    }
    
}
