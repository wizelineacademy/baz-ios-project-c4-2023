//
//  SearchViewController.swift
//  BAZProject
//
//  Created by jmgarciaca on 18/04/23.
//

import UIKit

// MARK: - SearchViewController
final class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txfSearch: UITextField!
    
    // MARK: - Properties
    
    var viewModel: SearchViewModel?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SearchViewModel()
        
        setupTable()
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: UIColor(named: "background") ?? .white, tintColor: .white, title: "Search", preferredLargeTitle: true)
    }
}

// MARK: - Methods

extension SearchViewController {
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
}

// MARK: - TableView's DataSource

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.numberOfSections() ?? 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection(section) ?? 0
    }
}

// MARK: - TableView's Delegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell()}
        
        if let movieVM = viewModel?.movieAtIndex(indexPath.row) {
            cell.setup(movieVM)
        }
        
        return cell
    }

}

// MARK: - TextField's Delegate

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let query = textField.text {
            viewModel?.search(query: query) { [weak self] in
                    self?.tableView.reloadData()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailVC") as? MovieDetailViewController {
            vc.movieVM = viewModel?.movieAtIndex(indexPath.row)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
