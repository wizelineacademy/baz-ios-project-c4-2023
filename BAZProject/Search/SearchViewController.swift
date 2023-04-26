//  SearchViewController.swift
//  BAZProject
//
//  Created by jehernandezg on 20/04/23.

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {

    var presenter: SearchViewOutputProtocol?
    private var moviesModel: [MovieResult]?
    {
        didSet {
            self.movieTableView.reloadData()
        }
    }
    
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
        tableView.backgroundColor = .white
        return tableView
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
            movieSearchBar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            movieSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            movieSearchBar.heightAnchor.constraint(equalToConstant: 32),
            
            movieTableView.topAnchor.constraint(equalTo: movieSearchBar.bottomAnchor, constant: 16),
            movieTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            movieTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            movieTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupTableView() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(HomeCell.self, forCellReuseIdentifier: "HomeCell")
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

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell {
            cell.setupTitle(title: self.moviesModel?[indexPath.row].title ?? "")
            self.presenter?.getMovieImage(index: indexPath.row, completion: { image in
                let imgDefault = UIImage(named: "poster") ?? UIImage()
                cell.setupImage(image: (image ?? imgDefault))
            })
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
