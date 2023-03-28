//
//  TrendingBarInteractor.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

class TrendingBarInteractor {
    weak var presenter: TrendingBarInteractorOutputProtocol?
    var remoteData: TrendingBarRemoteDataInputProtocol?
    
    private var trendingModel: [Movie] = []
    
}

extension TrendingBarInteractor: TrendingBarInteractorInputProtocol {
    func fetchMovieList(_ endPoint: Endpoint) {
        remoteData?.requestMovieList(byEndPoint: endPoint)
    }
    
    func fetchImageFrom(_ movie: MovieResult) {
        remoteData?.requestImageData(urlString: "\(MainConstants.mediaEndPoint)\(movie.posterPath ?? "")", completion: { [weak self] data in
            guard let imageData = data else { return }
            self?.presenter?.onReceivedMovie(with: Movie(id: movie.id ?? 0, title: movie.title ?? "", posterPath: imageData))
        })
    }
}

extension TrendingBarInteractor: TrendingBarRemoteDataOutputProtocol {
    func handleTrendingFetchedList(_ trendingList: TrendingMoviesResult) {
        self.presenter?.onReceivedTrendingList(with: trendingList)
    }
    
    func handleService(error: Error) {
        presenter?.onReceived(with: error)
    }
}
