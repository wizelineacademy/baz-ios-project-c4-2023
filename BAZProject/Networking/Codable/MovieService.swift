//
//  MovieService.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 13/04/23.
//

import Foundation

public struct MovieService: Decodable{
    var page: Int?
    var results: [MovieDetailService]?
}

public struct MovieDetailService: Decodable{
    var id: Int?
    var title: String?
    var poster_path: String?
    var overview: String?
}

extension MovieDetailService {
    func convertToMovieApp() -> Movie? {
        guard let id = id, let title = title, let poster_path = poster_path, let overview = overview else{ return nil }
        return Movie(id: id, title: title, poster_path: poster_path, overview: overview)
    }
}
