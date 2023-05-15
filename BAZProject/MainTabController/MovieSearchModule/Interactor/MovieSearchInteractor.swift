//
//  MovieSearchInteractor.swift
//  BAZProject
//
//  Created by 989438 on 18/04/23.
//

import Foundation

final class MovieSearchInteractor {
    weak var presenter: MovieSearchInteractorOutputProtocol?
    var remoteData: MovieSearchRemoteDataInputProtocol?
    
}

extension MovieSearchInteractor: MovieSearchInteractorInputProtocol {
    func fetchSearchMovieResults(_ endPoint: EndPointProtocol) {
        remoteData?.requestSearchMovie(byEndPoint: endPoint)
    }
    
    func fetchImageFrom(_ movie: MovieResult) {
        remoteData?.requestImageData(urlString: "\(EndPointConstants.mediaEndPoint)\(movie.posterPath ?? "")", completion: { [weak self] data in
            guard let imageData = data else { return }
            self?.presenter?.onReceivedMovie(with: Movie(id: movie.id ?? 0, title: movie.title ?? "", posterPath: imageData, summary: movie.overview ?? "", backdropPath: movie.backdropPath ?? "", backdropPathData: nil))
        })
    }
}

extension MovieSearchInteractor: MovieSearchRemoteDataOutputProtocol {
    func handleSearchingFetchedList(_ movieList: MoviesResult) {
        self.presenter?.onReceivedSearchedList(with: movieList)
    }
    
    func handleService(error: Error) {
        presenter?.onReceived(with: error)
    }
}
