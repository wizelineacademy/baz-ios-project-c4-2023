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

protocol NetworkingProtocol: AnyObject {
    var serviceDelegate: ServiceApiProtocol? { get set }
    func search(forPath strPath: String)
}

public enum ErrorApi: Error {
    case badURL
    case badJSON
    
    
    func getMessage() -> String {
        switch self {
        case .badURL:
            return NSLocalizedString("There was a problem creating the url", comment: "There was a problem creating the url")
        case .badJSON:
            return NSLocalizedString("There was a problem parsing the json", comment: "There was a problem parsing the json")
        }
    }
}

public class ServiceApi: NetworkingProtocol {
    
    private let strBaseURL: String = "https://api.themoviedb.org/3"
    private let strTokenKey: String = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"//URLCOMPONENTS
    
    public weak var serviceDelegate: ServiceApiProtocol?
    
    public init(serviceDelegate: ServiceApiProtocol? = nil) {
        self.serviceDelegate = serviceDelegate
    }
    
    func search(forPath strPath: String) {
        guard let url = URL(string: configureURL(forPath: strPath)) else {
            serviceDelegate?.serviceFinished(withResult: .failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: .init(url: url)) {[weak self] data, response, error in
            var dctResponse: [String : Any] = [String : Any]()
            defer {
                self?.serviceDelegate?.serviceFinished(withResult: .success(dctResponse))
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String : Any]
            else {
                self?.serviceDelegate?.serviceFinished(withResult: .failure(.badJSON))
                return
            }
            dctResponse = json

        }.resume()
    }
    
    public func configureURL(forPath strPath: String) -> String {
        return "\(strBaseURL)\(strPath)\(strTokenKey)"
    }
    
    
}
