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
    
    func setSectionsData() {
        for section in Sections.allCases {
            arrMovieListSections.append(Section(title: section.title))
        }
        presenter?.updateSectionsData(arrMovieListSections)
    }
    
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
    
    func searchMovies(for text: String) {
        movieAPI?.searchMoviesfor(keyword: text, completion: { movies in
            self.arrMoviesFound = movies
        })
    }
    
    func getMovie(for indexPath: IndexPath) -> MovieInfo? {
        arrMovieListSections[safe: indexPath.section]?.movies[safe: indexPath.row]
    }
    
    func getMovieFoundCount() -> Int? {
        arrMoviesFound?.count
    }
    
    func getMovieFound(for index: Int) -> MovieFoundInfo? {
        arrMoviesFound?[safe: index]
    }
    
    // MARK: - Private properties
    private func setMovies(_ movies: [MovieInfo]?, for section: Int) {
        self.arrMovieListSections[section].movies = movies ?? []
        self.presenter?.updateMovies(movies, in: section)
    }
}
