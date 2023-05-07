//
//  MasterMovieTableViewController.swift
//  BAZProject
//
//  Created by jmgarciaca on 17/04/23.
//

import UIKit


/// Protocol MasterMovieTableViewProtocols is used to define the requirements for a view controller or any object that displays a list of movies in a table view.
protocol MasterMovieTableViewProtocols {
    
    /// Sets up the view model for the list of movies to be displayed in the table view.
    /// - Parameters:
    ///    - viewModel: An instance of `MovieListViewModel` that contains the data needed to populate the table view.
    func setupViewModel(_ viewModel: MovieListViewModel)
}

/// A table view controller that displays a list of movies.
class MasterMovieTableViewController: UITableViewController {
    
    /// The view model that manages the data for the table view.
    var viewModel: MovieListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the table view
        configureTable()
    }
}

// MARK: - Methods

extension MasterMovieTableViewController {
    
    /// Configures the table view by registering the nib file for the movie table view cell.
    /// Returns: Void.
    func configureTable() {
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
}

// MARK: - TableView's DataSource

extension MasterMovieTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection(section) ?? 0
    }
}

// MARK: - TableView's Delegate

extension MasterMovieTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell()}
        
        if let movieVM = viewModel?.movieAtIndex(indexPath.row) {
            cell.setup(movieVM)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailVC") as? MovieDetailViewController {
            vc.movieVM = viewModel?.movieAtIndex(indexPath.row)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
