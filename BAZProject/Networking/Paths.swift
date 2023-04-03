//
//  Paths.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 03/04/23.
//

import Foundation

public struct URLConfiguration{
    var strMethod: String
    var strHost: String
    var path: Paths
    private var strCurrentLocale: String {
        if #available(iOS 16.0, *){
            return Locale.current.language.languageCode?.identifier ?? ""
        }else{
            return Locale.current.identifier
        }
    }
    
    public init(strMethod: String = "https", strHost: String = "api.themoviedb.org", path: Paths) {
        self.strMethod = strMethod
        self.strHost = strHost
        self.path = path
    }
    
    public func configureURL() -> URL? {
        var components = URLComponents()
        components.scheme = strMethod
        components.host = strHost
        components.path = path.rawValue
        components.queryItems = [URLQueryItem(name: "api_key", value: "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"),
                                 URLQueryItem(name: "language", value: strCurrentLocale)]
        
        return components.url
    }
}

public enum Paths: String {
    case trending = "/3/trending/movie/day"
    case noPath = ""
}
