//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

final class TrendingViewController: UITableViewController {
    private var moviesListVM: MovieListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Methods

extension TrendingViewController {
    
    /**
     Configures the view controller by loading trending movies for the day and populating the table view with the results.
    */
    private func setup() {

        let trendingMovieDayResource = Resource<MovieList>(url: Endpoint.trendingMovieDay.url) { data in
            return try? JSONDecoder().decode(MovieList.self, from: data)
        }
        
        MovieAPI().load(resource: trendingMovieDayResource) { [weak self] result in
            if let movieList = result {
                self?.moviesListVM = MovieListViewModel(movies: movieList.results)
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesListVM?.numberOfRowsInSection(section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") ?? UITableViewCell()
    }
}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        
        if let movieVM = moviesListVM.movieAtIndex(indexPath.row) {
            config.text = movieVM.title
            
            if let url = URL(string: movieVM.poster_path), let data = try? Data(contentsOf: url) {
                #warning("TODO: pending finish implementing the ImageLoader class with async")
                config.image = UIImage(data: data)
            } else {
                config.image = UIImage(named: "poster")
            }
        }
        
        cell.contentConfiguration = config
    }
}
