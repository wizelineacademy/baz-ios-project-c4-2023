//  HomeViewController.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.

import UIKit

//MARK: - Class
class HomeViewController: UITableViewController {
    //MARK: - Properties
    var presenter: HomeViewOutputProtocol?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
        self.tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.cellID)
        presenter?.getDataMovies()
//        presenter?.getDataMovies({
//            self.tableView.reloadData()
//        })
    }

}

//MARK: - Extensions
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getMoviesCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.cellID, for: indexPath) as? HomeCell else { fatalError("Unabel to create cell")}
        
        cell.setupTitle(title: presenter?.getMovieDescription(index: indexPath.row) ?? "")
        
        self.presenter?.getMovieImage(index: indexPath.row, completion: { image in
            cell.setupImage(image: image ?? UIImage())
        })

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}

// MARK: - P R E S E N T E R · T O · V I E W
extension HomeViewController: HomeViewInputProtocol {
    
    func showViewDataMovies(movies: [ListMovieProtocol]?) {
        self.tableView.reloadData()
    }
    
//    func showMoviesCount(count: Int) {
//        self.countRow = count
//        tableView(self.tableView, numberOfRowsInSection: count)
//    }
}
