//
//  MovieFakes.swift
//  BAZProjectTests
//
//  Created by 989438 on 28/03/23.
//

import Foundation
@testable import BAZProject

class MovieFakes {
    var movieList: Data { getDataFrom(json: "movieResult") }
    var reviewList: Data { getDataFrom(json: "reviewResponse")}
    var movieResult: MoviesResult { getObject() }
    var movieModel: MovieResult { getMovieResult() }
    
    // MARK: - Private methods
    private func getDataFrom(json file: String) -> Data {
        guard let path: String = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") else {
            fatalError("El archivo seleccionado no se encontró")
        }
        let data: Data = try! Data(contentsOf: URL(fileURLWithPath: path))
        return data
    }
    
    private func getObject() -> MoviesResult {
        let data = getDataFrom(json: "movieResult")
        let jsonData = try! JSONDecoder().decode(MoviesResult.self, from: data)
        return jsonData
    }
    
    private func getMovieResult() -> MovieResult {
        let data = getDataFrom(json: "movieResult")
        let jsonData = try! JSONDecoder().decode(MoviesResult.self, from: data)
        let movie = MovieResult(adult: false, backdropPath: jsonData.results?[0].backdropPath, id: jsonData.results?[0].id, title: jsonData.results?[0].title, originalLanguage: jsonData.results?[0].originalLanguage, originalTitle: jsonData.results?[0].originalTitle, overview: jsonData.results?[0].overview, posterPath: jsonData.results?[0].posterPath, mediaType: jsonData.results?[0].mediaType, genreIds: jsonData.results?[0].genreIds, popularity: jsonData.results?[0].popularity, releaseDate: jsonData.results?[0].releaseDate, video: jsonData.results?[0].video, voteAverage: jsonData.results?[0].voteAverage, voteCount: jsonData.results?[0].voteCount)
        return movie
    }
}
