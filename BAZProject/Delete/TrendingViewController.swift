//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

// MARK: - TrendingViewController Class
class TrendingViewController: UIViewController {
    
    @IBOutlet private var arrScrollingSections: [MovieListCollectionView]!
    
    private lazy var resultVC = UITableViewController()
    private lazy var searchController = UISearchController(searchResultsController: resultVC)
    private var strSearchText: String = ""
    
    private var arrMovieListSections: [MovieSection] = []

    var movies: [MovieInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.getMovies()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configNavbarTitle()
        self.configData()
    }
    
    private func configView() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Ingresa dirección"
        self.navigationItem.searchController = searchController
        searchController.showsSearchResultsController = true
        
        resultVC.tableView.delegate = self
        resultVC.tableView.dataSource = self
        resultVC.tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: MovieListCell.reusableIdentifier)
    }
    
    private func configNavbarTitle() {
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        navigationItem.title = "Movie App"
    }
    
    func configData() {
        arrMovieListSections = [
            Section(title: "Trending"),
            Section(title: "Now Playing"),
            Section(title: "Popular"),
            Section(title: "Top Rated"),
            Section(title: "Upcoming")
        ]
        
        for (index, movieListSection) in arrScrollingSections.enumerated() {
            movieListSection.setTitle(arrMovieListSections[index].strTitle)
        }
    }

    fileprivate func reloadMoviesData() {
        DispatchQueue.main.async {
            self.resultVC.tableView.reloadData()
        }
    }
    
    private func getMovies() {
        let movieApi = MovieAPI()
        movieApi.getTrendingMovies { movies in
            if let movies = movies, movies.count > 0 {
                self.arrScrollingSections[0].setMovies(movies)
                self.updateMovies(movies)
            } else {
                print("Empty results.")
            }
        }

        movieApi.getNowPlayingMovies { movies in
            if let movies = movies, movies.count > 0 {
                self.arrScrollingSections[1].setMovies(movies)
            } else {
                print("Empty results.")
            }
        }

        movieApi.getPopularMovies { movies in
            if let movies = movies, movies.count > 0 {
                self.arrScrollingSections[2].setMovies(movies)
            } else {
                print("Empty results.")
            }
        }

        movieApi.getTopRatedMovies { movies in
            if let movies = movies, movies.count > 0 {
                self.arrScrollingSections[3].setMovies(movies)
            } else {
                print("Empty results.")
            }
        }

        movieApi.getUpcomingMovies { movies in
            if let movies = movies, movies.count > 0 {
                self.arrScrollingSections[4].setMovies(movies)
                self.updateMovies(movies)
            } else {
                print("Empty results.")
            }
        }
        
        movieApi.searchMoviesfor(keyword: "Matrix") { arrMovies in
            if let movies = arrMovies, movies.count > 0 {
//                self.updateMovies(movies)
            }
        }
    }
    
    /**
     Set movies object into viewController.
     - Parameters:
        - arrMovies: An array of objects of type `MovieInfo` protocol.
     */
    private func updateMovies(_ arrMovies: [MovieInfo]) {
        self.movies = arrMovies
    }
}

// MARK: - TableView's DataSource
extension TrendingViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.reusableIdentifier) as? MovieListCell {
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }

}

// MARK: - TableView's Delegate
extension TrendingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let movieInfo = movies[indexPath.row]
        (cell as? MovieListCell)?.setData(with: movieInfo)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        let vc = DetailsViewController(movie: movie)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .formSheet
        self.present(navController, animated: true)
    }
}


extension TrendingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchBar:", searchText)
    }
}

extension TrendingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }
        self.strSearchText = searchBarText
        self.resultVC.view.backgroundColor = .clear
        self.resultVC.tableView.reloadData()
    }
    
}
