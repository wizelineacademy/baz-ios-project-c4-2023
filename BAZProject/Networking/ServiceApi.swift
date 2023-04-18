//
//  ServiceApi.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 27/03/23.
//

import Foundation

public protocol NetworkingProtocol: AnyObject {
    var configuration : URLConfiguration { get set }
    func search<T: Decodable>(withCompletionHandler handler: @escaping (Result<T, ErrorApi>) -> Void)
    func updatePath(with path: Paths)
}

extension NetworkingProtocol {
    public func updatePath(with path: Paths) {
        configuration.updatePath(with: path)
    }
}

public enum ErrorApi: Error {
    case badURL
    case badJSON
    case badResponse
    
    
    public func getMessage() -> String {
        switch self {
        case .badURL:
            return NSLocalizedString("There was a problem creating the url", comment: "There was a problem creating the url")
        case .badJSON:
            return NSLocalizedString("There was a problem parsing the json", comment: "There was a problem parsing the json")
        case .badResponse:
            return NSLocalizedString("The service didn't respond", comment: "The service didn't respond")
        }
    }
}

public class ServiceApi<T: Decodable>: NetworkingProtocol {
    public var configuration : URLConfiguration
    
    public init(configuration: URLConfiguration) {
        self.configuration = configuration
    }
    
    public func search<T>(withCompletionHandler handler: @escaping (Result<T, ErrorApi>) -> Void) where T : Decodable {
        guard let url = configuration.configureURL() else {
            DispatchQueue.main.async {
                handler(.failure(.badURL))
            }
            
            return
        }
        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                DispatchQueue.main.async {
                    handler(.failure(.badResponse))
                }
                return
            }
            DispatchQueue.main.async {
                if let json = try? JSONDecoder().decode(T.self, from: data){
                    handler(.success(json))
                }else{
                    handler(.failure(.badJSON))
                }
            }
            
        }.resume()
    }
}
