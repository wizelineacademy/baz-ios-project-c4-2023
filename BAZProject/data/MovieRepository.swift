//
//  MovieRepository.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 30/03/23.
//

import Foundation

protocol MovieRepository {
    func getAllMovie(completion: @escaping ([Movie]) -> Void)
}

class MovieDataSourceCache: MovieRepository {
    
    func getAllMovie(completion: @escaping ([Movie]) -> Void) {
        let movies = createMoviesFakes(3)
        completion(movies)
    }
    
    private func createMoviesFakes(_ count: Int) -> [Movie] {
        guard count > 0 else { return [] }
        var allMovies: [Movie] = []
        for i in 0..<count {
            let nameLength = Int.random(in: 9..<20)
            let name = randomString(length: nameLength)
            
            let randImage = Int.random(in: 0...9)
            let posterPath = "https://picsum.photos/300/10\(randImage)"
            
            let movie = Movie(id: i, title: name, poster_path: posterPath)
            allMovies.append(movie)
        }
        
        return allMovies
    }
    
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

class MovieDataSourceRemote: MovieRepository {
    
    func getAllMovie(completion: @escaping ([Movie]) -> Void){
        let movieApi = MovieAPI()
        movieApi.getMovies { movies in
            completion(movies)
        }
    }
}
