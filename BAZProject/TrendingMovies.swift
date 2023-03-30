//
//  File.swift
//  BAZProject
//
//  Created by bvelazquezva on 30/03/23.
//

import Foundation

class TrendingMovies: GeneralTaskCoordinatorProtocol{
    var session: URLSessionProtocol
    
    var urlPath: String = "trending/movie/day"
    
    func get<T>(callback: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        <#code#>
    }
    
    
}
