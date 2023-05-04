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
    
    var listMovies: [Movie] = []
    
    var tempImage: UIImage = UIImage()

    // MARK: Lifecycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        presenter?.tableView = tableView
        registrerCell()
    }
    
}

// MARK: - TableView's DataSource

extension SearchTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }

}

// MARK: - TableView's Delegate

extension SearchTableViewController {
}

// MARK: - SearchBar's Delegate
extension SearchTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.willFetchMovies(searchBar.text ?? "")
    }
}

extension SearchTableViewController: SearchViewProtocol {
    func setNavigationTitle(for strTitle: String?){
        navigationItem.title = strTitle
    }
    
    func registrerCell(){
        tableView.register(UINib(nibName: GeneralTableViewCell.identifier, bundle : nil), forCellReuseIdentifier: GeneralTableViewCell.identifier)
    }
    
    func updateData(_ result: [Movie]) {
        self.listMovies = result
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func getPoster(_ posterImage: UIImage) {
        DispatchQueue.main.async {
            self.tempImage = posterImage
        }
        
    }
}
