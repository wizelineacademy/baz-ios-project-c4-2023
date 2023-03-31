//
//  Interactor.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 29/03/23.
//

import Foundation

protocol InteractorToPresenter {
    func manageResponse(results: [Viewable])
}

///Enumeration that stores the diferent urls used for the project
enum serviceUrls: String {
    case trending = "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
}

class Interactor: PresenterToInteractor {
    
    // MARK: Variables
    var presenter: InteractorToPresenter?
    
    func consultTheMovieApi() {
        
        let urlString = (serviceUrls.trending.rawValue)
        guard let url = URL(string: urlString) else {
            // TODO: (SDA) Presentar un error al formar la url
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error = error {
                // TODO: (SDA) Presentar error en el request
                return
            }
            guard let data = data,
                  let response = try? JSONDecoder().decode(MovieApiResult.self, from: data) else {
                // TODO: (SDA) Presentar un error al decodificar la información
                return
            }
            // TODO: (SDA) Qué hacer son el response
            DispatchQueue.main.async {
                guard let movies = response.results else { return }
                self.presenter?.manageResponse(results: movies)
            }
        }
        task.resume()
    }
    
    // MARK: PresenterToInteractor methods
    func getMoviesData() {
        self.consultTheMovieApi()
    }
}
