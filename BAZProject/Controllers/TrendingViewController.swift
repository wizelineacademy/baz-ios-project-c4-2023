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
        let movieApi = MovieAPI()
        
        movieApi.getMovies { movies in
            self.moviesListVM = MovieListViewModel(movies: movies)
            
            DispatchQueue.main.async {
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
