//
//  SearchMoviesViewController.swift
//  BAZProject
//
//  Created by 989438 on 29/03/23.
//

import UIKit

final class SearchMoviesViewController: UITableViewController, ReusableIdentifierProtocol {
    var presenter: MovieSearchPresenterProtocol?
    let searchBarController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = NSLocalizedString(MainLocalizableString.searchScreenTitle.rawValue, comment: "")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SearchMoviesViewController.reusableIdentifier)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.searchController = searchBarController
        searchBarController.searchBar.delegate = self
        self.definesPresentationContext = true
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController?.searchBar.sizeToFit()
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension SearchMoviesViewController: MovieSearchViewControllerProtocol {
    func reloadMovieInfo() {
        tableView.reloadData()
    }
    
    func fillMovieList() {
        presenter?.reloadInfo()
    }
    
    func reload(with error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension SearchMoviesViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count: Int = presenter?.movieModel.count else {
            return .zero
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: SearchMoviesViewController.reusableIdentifier) ?? UITableViewCell()
    }

}

extension SearchMoviesViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = presenter?.movieModel[indexPath.row].title
        config.image = UIImage(data: presenter?.movieModel[indexPath.row].posterPath ?? Data())
        cell.contentConfiguration = config
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath)
    }

}

extension SearchMoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        presenter?.searchMovie(withQuery: query)
    }
}
