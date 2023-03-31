//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {
    
    private var moviesListVM: MovieListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

extension TrendingViewController {
    public func setup() {

        let urlForTrendingMovieDay = URL(string: Constants.Paths.urlForTrendingMovieDay)!

        let trendingMovieDayResource = Resource<MovieList>(url: urlForTrendingMovieDay) { data in
            return try? JSONDecoder().decode(MovieList.self, from: data)
        }
        
        MovieAPI().load(resource: trendingMovieDayResource) { (result) in
            if let movieList = result {
                self.moviesListVM = MovieListViewModel(movies: movieList.results)
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesListVM?.numberOfRowsInSection(section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        
        let movieVM = self.moviesListVM.movieAtIndex(indexPath.row)
        
        config.text = movieVM.title
        
        if let url = URL(string: movieVM.poster_path), let data = try? Data(contentsOf: url) {
             config.image = UIImage(data: data)
        } else {
            config.image = UIImage(named: "poster")
        }
        
        cell.contentConfiguration = config
    }

}
