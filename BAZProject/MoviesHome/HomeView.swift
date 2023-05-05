//
//  HomeView.swift
//  BAZProject
//
//  Created by Carlos Garcia on 20/04/23.
//  
//

import Foundation
import UIKit

class HomeView: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var mainStackContainer: UIStackView!
    
    var presenter: HomePresenterProtocol?
    
    private lazy var resultVC = UITableViewController()
    private lazy var searchController = UISearchController(searchResultsController: resultVC)
    private var isEmptyResults: Bool = false

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
        self.presenter?.getData()
        self.presenter?.fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightButton(title: "My List", action: #selector(self.showFavoriteMoviesView(_:)))
    }
    
    private func configView() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.showsSearchResultsController = true
        searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
        
        resultVC.tableView.delegate = self
        resultVC.tableView.dataSource = self
    }
    
    private func configNavbarTitle(_ strTitle: String?) {
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        navigationItem.title = strTitle
    }
    
    private func addSectionView(_ section: MovieListCollectionView) {
        mainStackContainer.addArrangedSubview(section)
    }
    
    @objc private func showFavoriteMoviesView(_ sender: Any) {
        presenter?.goToFavoriteMovies()
    }
}

extension HomeView: HomeViewProtocol {
    func setNavigationTitle(for strTitle: String?){
        configNavbarTitle(strTitle)
    }
    
    func updateSectionsData(_ collectionList: [MovieListCollectionView]) {
        for sectionColl in collectionList {
            addSectionView(sectionColl)
        }
    }
    
    func reloadSearchResults() {
        self.resultVC.tableView.reloadData()
    }
    
    func showEmptyResults() {
        self.isEmptyResults = true
        self.resultVC.tableView.reloadData()
    }
}

// MARK: - TableView's DataSource
extension HomeView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isEmptyResults ? 1 : presenter?.numberOfRowsForSearch() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - TableView's Delegate
extension HomeView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = cell.defaultContentConfiguration()
        if let movieInfo = presenter?.getMovieSearch(for: indexPath) {
            config.text = movieInfo.title
        } else {
            config.text = "Results not found"
        }
        cell.contentConfiguration = config
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToMovieDetails(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension HomeView: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText: String = searchBar.text else { return }
        presenter?.fetchMovies(for: searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        isEmptyResults = false
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isEmptyResults = false
            presenter?.resetSearch()
        } else {
            presenter?.fetchMovies(for: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.resetSearch()
    }
}

extension HomeView: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        resultVC.view.backgroundColor = .white
        resultVC.tableView.reloadData()
    }
}
