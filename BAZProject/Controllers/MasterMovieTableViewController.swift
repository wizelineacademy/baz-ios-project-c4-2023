//
//  MasterMovieTableViewController.swift
//  BAZProject
//
//  Created by jmgarciaca on 17/04/23.
//

import UIKit

/**
Protocol MasterMovieTableViewProtocols is used to define the requirements for a view controller or any object that displays a list of movies in a table view.
*/
protocol MasterMovieTableViewProtocols {
    
    /// Sets up the view model for the list of movies to be displayed in the table view.
    ///
    /// - Parameters:
    ///    - viewModel: An instance of `MovieListViewModel` that contains the data needed to populate the table view.
    func setupViewModel(_ viewModel: MovieListViewModel)
}

class MasterMovieTableViewController: UITableViewController {
    
    var viewModel: MovieListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTable()
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: UIColor(named: "background") ?? .white, tintColor: .white, title: "Movies", preferredLargeTitle: true)
    }
}

// MARK: - Methods

extension MasterMovieTableViewController {
    
    /// Configures the table view by registering the nib file for the movie table view cell.
    ///
    /// Returns: Void.
    func configureTable() {
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier:"movieCell")
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
        
        cell.delegate = self
        
        if let movieVM = viewModel?.movieAtIndex(indexPath.row) {
            cell.setup(movieVM)
        }
        
        return cell
    }

}

// MARK: - TableView's CellProtocols

extension MasterMovieTableViewController: MovieTableViewCellProtocols {
    
    func didTapCell(_ movieVM: MovieViewModel?) {
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailVC") as? MovieDetailViewController {
            vc.movieVM = movieVM
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
