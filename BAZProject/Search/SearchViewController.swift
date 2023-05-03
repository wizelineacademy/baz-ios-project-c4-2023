//  SearchViewController.swift
//  BAZProject
//
//  Created by jehernandezg on 20/04/23.

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    // MARK: Properties
    private lazy var movieSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = LocalizableString.searchPlaceholder.localized
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    var presenter: SearchViewOutputProtocol?
    private var moviesModel: [MovieResult]?
    {
        didSet {
            self.movieTableView.reloadData()
        }
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.AppColors.homeBackgroundColor
        title = LocalizableString.searchTitle.localized
        initComponents()
    }
    
    // MARK: Functions
    private func initComponents() {
        addTableView()
        setupTableView()
    }
    
    private func addTableView() {
        self.view.addSubview(movieSearchBar)
        self.view.addSubview(movieTableView)
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            movieSearchBar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: ConstraintConstants.medium),
            movieSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstraintConstants.regular),
            movieSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ConstraintConstants.regular),
            movieSearchBar.heightAnchor.constraint(equalToConstant: ConstraintConstants.large),
            
            movieTableView.topAnchor.constraint(equalTo: movieSearchBar.bottomAnchor, constant: ConstraintConstants.regular),
            movieTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(HomeCell.self, forCellReuseIdentifier: CellConstants.cellID)
    }
    
    // MARK: - searchBar Delegates
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        let keyWord = searchBar.text ?? ""
        presenter?.getMovieSearch(endPoint: .search(query: keyWord))
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

}

// MARK: - Extensions
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.cellID) as? HomeCell {
            cell.isHome = false
            cell.searchPresenter = presenter
            cell.index = indexPath.row
            cell.model = self.moviesModel?[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesModel?.count ?? 0
    }
    
}

// MARK: - P R E S E N T E R · T O · V I E W
extension SearchViewController: SearchViewInputProtocol {
    func showViewDataMovies(movies: [ListMovieProtocol]?) {
        self.moviesModel = movies as? [MovieResult]
    }
}
