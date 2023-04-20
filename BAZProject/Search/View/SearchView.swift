//
//  SearchView.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation
import UIKit

class SearchView: UIViewController {
    
    @IBOutlet weak var schBar: UISearchBar!
    
    @IBOutlet weak var tblContent: UITableView!
    
    // MARK: Properties
    var presenter: SearchPresenterProtocol?

    // MARK: Lifecycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

// MARK: - TableView's DataSource

extension SearchView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        entity?.result?.count ?? 0
        0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier, for: indexPath) as? TrendingTableViewCell{
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }

}

// MARK: - TableView's Delegate

extension SearchView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = entity?.result?[indexPath.row].title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }

}

// MARK: - SearchBar's Delegate
extension SearchView: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        <#code#>
    }
}

extension SearchView: SearchViewProtocol {
    // TODO: implement view output methods
    func setNavigationTitle(for strTitle: String?){
        navigationItem.title = strTitle
    }
}
