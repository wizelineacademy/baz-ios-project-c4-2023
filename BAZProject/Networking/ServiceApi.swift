//
//  ServiceApi.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 27/03/23.
//

import Foundation

public protocol ServiceApiProtocol: AnyObject {
    func serviceFinished(withResult result: Result<[String : Any], ErrorApi>)
}

public protocol NetworkingProtocol: AnyObject {
    var serviceDelegate: ServiceApiProtocol? { get set }
    var configuration : URLConfiguration { get set }
    func search()
}

public enum ErrorApi: Error {
    case badURL
    case badJSON
    case badResponse
    
    
    func getMessage() -> String {
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

public class ServiceApi: NetworkingProtocol {
    
    public weak var serviceDelegate: ServiceApiProtocol?
    public var configuration : URLConfiguration
    
    public init(serviceDelegate: ServiceApiProtocol? = nil, configuration: URLConfiguration) {
        self.serviceDelegate = serviceDelegate
        self.configuration = configuration
    }
    
    public func search() {
        guard let url = configuration.configureURL() else {
            serviceDelegate?.serviceFinished(withResult: .failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: .init(url: url)) { [weak self] data, response, error in
            var dctResponse: [String : Any] = [String : Any]()
            defer {
                self?.serviceDelegate?.serviceFinished(withResult: .success(dctResponse))
            }
            guard let data = data, let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                self?.serviceDelegate?.serviceFinished(withResult: .failure(.badResponse))
                return
            }
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String : Any]{
                dctResponse = json
            }else{
                self?.serviceDelegate?.serviceFinished(withResult: .failure(.badJSON))
            }
            

        }.resume()
    }
}
