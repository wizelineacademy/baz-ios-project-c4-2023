//
//  HomeInteractor.swift
//  BAZProject
//
//  Created by Carlos Garcia on 20/04/23.
//  
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: HomeInteractorOutputProtocol?
    var movieAPI: MovieAPI?
    var entity: HomeEntity?
    
    var arrMoviesFound: [MovieFoundInfo]? {
        didSet {
            presenter?.updateMoviesFound(arrMoviesFound)
        }
    }
    
    private var arrMovieListSections: [MovieSection] = []

    func getNavTitle() -> String?{
        return entity?.strNavBarTitle
    }
    
    /**
     Get fetch movies..
     
     Fetch movies for the data section with the MovieAPI services. Result is returned through the Present.
     
     - Parameters:
        - section: Int that represent the section index.
     */
    func setSectionsData() {
        for section in Sections.allCases {
            arrMovieListSections.append(Section(title: section.title))
        }
        presenter?.updateSectionsData(arrMovieListSections)
    }
    
    /**
     Get fetch movies.
     
     Fetch movies for the data section with the MovieAPI services. Result is returned through the Present.
     
     - Parameters:
        - section: Int that represent the section index.
     */
    func fetchMovies(for section: Int) {
        switch section {
        case 0:
            movieAPI?.getTrendingMovies(completion: {[weak self] movies in
                self?.setMovies(movies, for: section)
            })
        case 1:
            movieAPI?.getNowPlayingMovies(completion: {[weak self] movies in
                self?.setMovies(movies, for: section)
            })
        case 2:
            movieAPI?.getPopularMovies(completion: {[weak self] movies in
                self?.setMovies(movies, for: section)
            })
        case 3:
            movieAPI?.getTopRatedMovies(completion: {[weak self] movies in
                self?.setMovies(movies, for: section)
            })
        case 4:
            movieAPI?.getUpcomingMovies(completion: {[weak self] movies in
                self?.setMovies(movies, for: section)
            })
        default: return
        }
    }
    
    /**
     Search movies for string key.
     
     - Parameters:
        - text: A string that represents the keyword(s) for the search.
     */
    func searchMovies(for text: String) {
        movieAPI?.searchMoviesfor(keyword: text, completion: { movies in
            self.arrMoviesFound = movies
        })
    }
    
    /**
     Get movie info object.
     
     - Parameters:
        - indexPath: Represents the section and index of the movie to return its information.
     */
    func getMovie(for indexPath: IndexPath) -> MovieInfo? {
        arrMovieListSections[safe: indexPath.section]?.movies[safe: indexPath.row]
    }
    
    /**
     Return the number of items found for the search section.
     */
    func getMovieFoundCount() -> Int? {
        arrMoviesFound?.count
    }
    
    /**
     Get movie info fot the search section.
     
     - Parameters:
        - indexPath: Represent the section and index of the movie to search info.
     */
    func getMovieFound(for index: Int) -> MovieFoundInfo? {
        arrMoviesFound?[safe: index]
    }
    
    // MARK: - Private properties
    private func setMovies(_ movies: [MovieInfo]?, for section: Int) {
        self.arrMovieListSections[section].movies = movies ?? []
        self.presenter?.updateMovies(movies, in: section)
    }
}
