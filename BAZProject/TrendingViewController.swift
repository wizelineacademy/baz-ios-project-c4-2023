//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {

    private var moviesListViewModel: MoviesListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let getService = MovieAPI(session: URLSession.shared)
        getService.getMovies(.getMovies){ [weak self] (result: Result< [Movie], Error>) in
            switch result {
            case .success(let moviesReponse):
                self?.moviesListViewModel = MoviesListViewModel(movies: moviesReponse)
            default:
                print("Error.....")
            }
        }
        
    }

}

// MARK: - TableView's DataSource
extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesListViewModel?.movies.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate
extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        let infoMovieCell = moviesListViewModel?.movieAtIndex(indexPath.row)
        config.text = infoMovieCell?.title
        config.image = UIImage(data: infoMovieCell?.poster_path ?? Data())
        cell.contentConfiguration = config
    }

}
