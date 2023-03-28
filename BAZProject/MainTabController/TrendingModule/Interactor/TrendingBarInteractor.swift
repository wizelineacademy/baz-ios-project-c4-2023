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
}

extension TrendingBarInteractor: TrendingBarRemoteDataOutputProtocol {
    func handleTrendingFetchedList(_ trendingList: TrendingMoviesResult) {
        createTrendingModel(with: trendingList) { [weak self] _ in
            self?.presenter?.onReceivedTrendingList(with: self?.trendingModel ?? [])
        }
    }
    
    func handleService(error: Error) {
        presenter?.onReceived(with: error)
    }
    
    private func createTrendingModel(with trendingList: TrendingMoviesResult, completion: @escaping ([Movie?]) -> Void) {
        self.trendingModel.removeAll()
        if let movies = trendingList.results {
            let myTrendingGroup = DispatchGroup()
            for movie in movies {
                myTrendingGroup.enter()
                remoteData?.requestImageData(urlString: "\(MainConstants.mediaEndPoint)\(movie.posterPath ?? "")", completion: { [weak self] data in
                    guard let imageData = data else { return }
                    self?.trendingModel.append(Movie(id: movie.id ?? 0, title: movie.title ?? "", posterPath: imageData))
                    myTrendingGroup.leave()
                })
            }
            myTrendingGroup.notify(queue: .main) {
                completion(self.trendingModel)
            }
        }
    }
}
