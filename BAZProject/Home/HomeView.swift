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
    private var arrMoviesFound: [MovieFoundInfo]? {
        didSet {
            self.resultVC.tableView.reloadData()
        }
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
        self.presenter?.getData()
        self.presenter?.fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configView() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Busqueda"
        self.navigationItem.searchController = searchController
        searchController.showsSearchResultsController = true
        
        resultVC.tableView.delegate = self
        resultVC.tableView.dataSource = self
        resultVC.tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: MovieListCell.reusableIdentifier)
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
    
    func showMoviesFound(_ movies: [MovieFoundInfo]?) {
        self.arrMoviesFound = movies
    }
}


// MARK: - TableView's DataSource
extension HomeView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrMoviesFound?.count ?? 0
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
extension HomeView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let movieInfo = presenter?.getSearchMovie(for: indexPath) else { return }
        guard let movieInfo = arrMoviesFound?[safe: indexPath.row] else { return }
        (cell as? MovieListCell)?.setData(with: movieInfo)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let movieInfo = presenter?.getMovie(at: indexPath.row) else { return }
//        let vc = DetailsViewController(movie: movieInfo)
//        let navController = UINavigationController(rootViewController: vc)
//        navController.modalPresentationStyle = .formSheet
//        self.present(navController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


extension HomeView: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        presenter?.fetchMovies(for: searchBar.text)
    }
}

extension HomeView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        guard let searchBarText = searchController.searchBar.text else { return }
        // TODO: Call search service with keyword
        self.resultVC.view.backgroundColor = .white
//        self.resultVC.tableView.reloadData()
    }
    
}
