//
//  TrendingMoviesViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingMoviesViewController: UIViewController {
    
    private var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TrendingTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var movies: [Movie] = []
    
    static func getInstance() -> TrendingMoviesViewController {
        let vc = TrendingMoviesViewController()
        vc.title = "Trending"
        vc.tabBarItem = UITabBarItem(title: vc.title, image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewContstraints()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        view.backgroundColor = .systemBackground
        let movieApi = TrendingAPIService()
        
        movieApi.getMovies { movies in
            self.movies = movies
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }
    
    private func setTableViewContstraints() {
        view.addSubview(moviesTableView)
        moviesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        moviesTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        moviesTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    }

}

// MARK: - TableView's DataSource

extension TrendingMoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") ?? UITableViewCell()
    }

}

// MARK: - TableView's Delegate

extension TrendingMoviesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = UIImage(named: "poster") ?? UIImage(systemName: "photo")
        config.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        cell.indentationLevel = 1
        cell.indentationWidth = 0
        cell.contentConfiguration = config
    }

}
