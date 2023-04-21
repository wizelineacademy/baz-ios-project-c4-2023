//
//  SearchTableViewController.swift
//  BAZProject
//
//  Created by Ben Frank V. on 20/04/23.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    @IBOutlet weak var schBar: UISearchBar!{
        didSet{
            schBar.delegate = self
        }
    }
        
    // MARK: Properties
    var presenter: SearchPresenterProtocol?
    
    var serchingName = [String]()
    var searching = false

    // MARK: Lifecycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        presenter?.tableView = tableView
    }
    
}

// MARK: - TableView's DataSource

extension SearchTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        entity?.result?.count ?? 0
        return presenter?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }

}

// MARK: - TableView's Delegate

extension SearchTableViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
    }

}

// MARK: - SearchBar's Delegate
extension SearchTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Enter presionado")
        presenter?.willFetchMovies(searchBar.text ?? "")
    }
}

extension SearchTableViewController: SearchViewProtocol {
    func setNavigationTitle(for strTitle: String?){
        navigationItem.title = strTitle
    }
    
    func registrerCell(){
        tableView.register(UINib(nibName: TrendingTableViewCell.identifier, bundle : nil), forCellReuseIdentifier: TrendingTableViewCell.identifier)
    }
}
