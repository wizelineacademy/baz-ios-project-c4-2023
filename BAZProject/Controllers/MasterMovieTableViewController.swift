//
//  MasterMovieTableViewController.swift
//  BAZProject
//
//  Created by jmgarciaca on 17/04/23.
//

import UIKit

protocol MasterMovieTableViewProtocols {
    func setupViewModel(_ viewModel: MovieListViewModel)
}

class MasterMovieTableViewController: UITableViewController {
    
    var viewModel: MovieListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier:"movieCell")
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: UIColor(named: "background") ?? .white, tintColor: .white, title: "Movies", preferredLargeTitle: true)
    }
}

// MARK: - TableView's DataSource

extension MasterMovieTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.numberOfSections() ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection(section) ?? 0
    }
}

// MARK: - TableView's Delegate

extension MasterMovieTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell()}
        
        if let movieVM = viewModel?.movieAtIndex(indexPath.row) {
            cell.setup(movieVM)
        }
        
        return cell
    }

}
