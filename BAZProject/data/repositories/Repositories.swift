//
//  MovieRepository.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 30/03/23.
//

import Foundation

// MARK: - Protocol para la lista de Peliculas
protocol MoviesRepository {
    func getAllMovie(filter: Filters, completion: @escaping ([Movie]) -> Void)
    func getRelatedMovies(filter: Filters, movieID: Int, completion: @escaping ([Movie]) -> Void)
}

// MARK: - Protocol para trabajar con información particular de una pelicula
protocol MovieRepository {
    func getCast(movieID: Int, completion: @escaping ([Actor]) -> Void)
    func getReviews(movieID: Int, completion: @escaping ([Review]) -> Void)
}

// MARK: - Protocol para la busqueda en base a una palabra clave
protocol SearchRepository {
    func searchMovies(query: String, completion: @escaping ([Movie]) -> Void)
    func searchKeyword(query: String, completion: @escaping ([String]) -> Void)
}
