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
    func search(forPath path: Paths)
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
    
    private let strBaseURL: String = "https://api.themoviedb.org/3"
    private let strTokenKey: String = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"//URLCOMPONENTS
    private var strCurrentLocale: String {
        if #available(iOS 16.0, *){
            return Locale.current.language.languageCode?.identifier ?? ""
        }else{
            return Locale.current.identifier
        }
    }
    
    public weak var serviceDelegate: ServiceApiProtocol?
    
    public init(serviceDelegate: ServiceApiProtocol? = nil) {
        self.serviceDelegate = serviceDelegate
    }
    
    public func search(forPath path: Paths) {
        guard let url = configureURL(forPath: path) else {
            serviceDelegate?.serviceFinished(withResult: .failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: .init(url: url)) {[weak self] data, response, error in
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
    
    public func configureURL(forPath path: Paths) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3\(path.rawValue)"
        components.queryItems = [URLQueryItem(name: "api_key", value: "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"),
                                 URLQueryItem(name: "language", value: strCurrentLocale)]
        return components.url
    }
}
