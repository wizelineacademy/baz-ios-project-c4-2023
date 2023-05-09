//
//  MoviesFavoritesViewController.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 08/05/23.
//

import UIKit
import CoreData

// MARK: Class
class MoviesFavoritesViewController: ReusableViewController {

    private let tlvFavorites = UITableView()
    private let moviesFavoritesViewModel = MoviesFavoritesViewModel()

    // MARK: - Override Functions
    override func setupView() {
        super.setupView()
        tlvFavorites.backgroundColor = .white
        view.addSubview(tlvFavorites)
        tlvFavorites.dataSource = self
        tlvFavorites.delegate = self
        let reuseIdentifier = NSStringFromClass(SearchMovieItemAdapter.self)
        tlvFavorites.register(SearchMovieItemAdapter.self, forCellReuseIdentifier: reuseIdentifier)

        tlvFavorites.translatesAutoresizingMaskIntoConstraints = false
        tlvFavorites.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tlvFavorites.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tlvFavorites.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tlvFavorites.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesFavoritesViewModel.fetchMoviesFavorites()
        moviesFavoritesViewModel.onMoviesUpdate = {
            DispatchQueue.main.async {
                self.tlvFavorites.reloadData()
            }
        }
    }

}

extension MoviesFavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesFavoritesViewModel.movies.count == 0 {
            tlvFavorites.setEmptyMessage("favoritesEmpty".localized)
        } else {
            tlvFavorites.restore()
        }
        return moviesFavoritesViewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = NSStringFromClass(SearchMovieItemAdapter.self)
        if let movieCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SearchMovieItemAdapter {
            let movieEntity = moviesFavoritesViewModel.movies[indexPath.row]
            let movieItem = Movie(id: Int(movieEntity.id), title: movieEntity.title ?? "", posterPath: movieEntity.posterPath, overview: movieEntity.overview ?? "", voteAverage: movieEntity.voteAverage, releaseDate: movieEntity.releaseDate ?? "")
            movieCell.item = movieItem
            return movieCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        .dim100
    }
}
