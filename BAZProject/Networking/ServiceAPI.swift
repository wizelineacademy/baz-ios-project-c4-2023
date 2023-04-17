//
//  ServiceAPI.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

/**
 Class in charge to perform the network data transfer tasks.
 
 ### Declaration Example: ###
 ````
 let serviceApi = ServiceAPI(session: URLSession.shared)
 ````
 
 - Version: 1.0.0
 */
final class ServiceAPI: Service {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func get<T: Decodable>(_ endpoint: EndPointProtocol, callback: @escaping (Result<T,Error>) -> Void) {
        let request = endpoint.request
        DispatchQueue.global().async {
            let task = self.session.performDataTask(with: request) { (data, response, error) in

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

    func fetchImageData(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }
        task.resume()
    }
}
