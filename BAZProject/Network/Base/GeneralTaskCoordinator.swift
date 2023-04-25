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
    var apiKey: String {get}
    var api:String {get}
    var languageKey: String {get}
    var languageValueDefault: String {get}
    var regionKey: String {get}
    var regionValueDefault: String {get}
    var pageKey: String {get}
    var pageValueDefault: String {get}
    var queryKey: String {get}
    var queryValue: String {get set}
    var params: [URLQueryItem] {get set}
    func get<T: Decodable>(_ type: URLType, callback: @escaping (Result<T,Error>) -> Void)
}

extension GeneralTaskCoordinatorProtocol {
    var urlBase: String {return .urlBase}
    var apiKey: String {return .apiKey}
    var api: String {return "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"}
    var languageKey: String {return .languageKey}
    var languageValueDefault: String {return .languageValueDefault}
    var regionKey: String {return .regionKey}
    var regionValueDefault: String {return .regionValueDefault}
    var pageKey: String {return .pageKey}
    var pageValueDefault: String {return .pageValueDefault}
    var queryKey: String {return .queryKey}
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
    var params: [URLQueryItem] = []
    var queryValue: String = ""
    
    var session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func get<T: Decodable>(_ type: URLType = .generic, callback: @escaping (Result<T,Error>) -> Void) {
        let urlString: String = "\(urlBase)\(urlPath)"
        let apiQuery = URLQueryItem(name: apiKey, value: api)
        let lenguageQuery = URLQueryItem(name: languageKey, value: languageValueDefault)
        let regionQuery = URLQueryItem(name: regionKey, value: regionValueDefault)
        var params: [URLQueryItem] = [apiQuery, lenguageQuery, regionQuery]
        
        switch(type){
            case .generic:
                params.append(URLQueryItem(name: pageKey, value: pageValueDefault))
            case .allCustom:
                break
            case .search:
                params.append(URLQueryItem(name: queryKey, value: queryValue))
        }
        
        guard let url = addQueryParams(url: URL(string: urlString), newParams: params) else {return}
        
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
    
    func fetchImageData(posterPath: String, completion: @escaping (Data?) -> Void) {
        
        let urlString = .posterBasePath + posterPath
        
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
    
    func addQueryParams(url: URL?, newParams: [URLQueryItem]) -> URL? {
        guard let url = url else {return nil}
        let urlComponents = NSURLComponents.init(url: url , resolvingAgainstBaseURL: false)
        guard urlComponents != nil else { return nil; }
        if (urlComponents?.queryItems == nil) {
            urlComponents!.queryItems = [];
        }
        urlComponents!.queryItems!.append(contentsOf: newParams);
        return urlComponents?.url;
    }
}

public enum URLType {
    case generic
    case allCustom
    case search
}
