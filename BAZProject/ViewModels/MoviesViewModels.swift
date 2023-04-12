//
//  MoviesViewModels.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 03/04/23.
//

/*
import Foundation
import UIKit

struct MoviesViewModels{
    private let movie: MoviesResult
}

extension MoviesViewModels{
    init(_ movie: MoviesResult) {
        self.movie = movie
    }
}

extension MoviesViewModels{
    var title: String {
        return self.movie.title ?? ""
    }
    
    func getImage(completion: @escaping(UIImage) ->()){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(self.movie.PosterPath ?? "")") else { return }
        let globalQueue = DispatchQueue.global()
        globalQueue.async {
            if let data = try? Data(contentsOf: url){
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image ?? UIImage())
                }
            }
        }
    }
}

struct MoviesListViewModel{
    let movies: [MoviesResult]
}

extension MoviesListViewModel {
    var numberOfSections: Int {
        return movies.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.movies.count
    }
    
    func movieAtIndex(_ index: Int) -> MoviesViewModels {
        let movie = self.movies[index]
        return MoviesViewModels(movie)
    }
}

*/
