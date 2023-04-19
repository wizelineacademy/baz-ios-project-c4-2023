//
//  MoviesView.swift
//  BAZProject
//
//  Created by nmorenoa on 14/04/23.
//
import UIKit
import Foundation

class MoviesView: UIViewController{
    
    @IBOutlet weak var tblSearch: UITableView!{
        didSet{
            style(to: tblSearch)
            registerNibs(in: tblSearch)
            tblSearch.delegate      = self
            tblSearch.dataSource    = self
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Properties
    var presenter           : MoviesViewOutputProtocol?
    var movies              : [MovieData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    private func style(to tableView: UITableView){
        tableView.bounces                        = false
        tableView.separatorStyle                 = .none
        tableView.backgroundColor                = .white
        tableView.allowsSelection                = true
        tableView.alwaysBounceVertical           = false
        tableView.alwaysBounceHorizontal         = false
        tableView.allowsMultipleSelection        = false
        tableView.showsVerticalScrollIndicator   = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.estimatedRowHeight             = UITableView.automaticDimension
    }
    
    private func registerNibs(in tableView: UITableView) {
        tableView.register(UINib(nibName: CellMovies.identifier, bundle: nil),
                           forCellReuseIdentifier: CellMovies.identifier)
    }
    
}
//MARK: - Delegate UISearchBar
extension MoviesView: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        presenter?.searchMoview(with: searchBar.text ?? "")
    }
    
}
//MARK: - Delegate TableView
extension MoviesView: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"CellMovies", for: indexPath) as? CellMovies else {
            return UITableViewCell()
        }
        let infoCell                = movies[indexPath.row]
        cell.descriptionMovie.text  = infoCell.title
        infoCell.getImage(){ imagen in
            cell.imgMovie.image         = imagen
        }
        return cell
    }
    
}
extension MoviesView: MoviesViewInputProtocol{
    func showResultMovies(with moviesData: [MovieData]) {
        self.movies.removeAll()
        self.movies = moviesData
        DispatchQueue.main.async {
            self.tblSearch.reloadData()
        }
    }
}
