//
//  SearchView.swift
//  BAZProject
//
//  Created by Manuel S on 18/04/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - OUtlets y variables
    
    var viewModel: SearchViewModel = SearchViewModel()// se crea instancia al ViewModel de MVVM
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.showsScopeBar = true
            searchBar.scopeButtonTitles = ["Pelicula","Actor"]
            searchBar.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }

/// Configuracion necesaria para la vista
    func configureView() {
        self.title = "Buscar"
        searchBar.showsCancelButton = true
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.selectedScopeButtonIndex = SearchTypes.Movie
        registerTableViewCells()
        viewModel.bindMovies { [weak self] in // Bind para relacionar Vista con ViewModel
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.searchMovie(title: searchBar.text ?? "")
    }
    ///Registro de las celas de las peliculas
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "SearchTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "cell")
    }
}

// MARK: - Extensions TableView

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.selectedScopeButtonIndex == SearchTypes.Movie {
            return  viewModel.getMovieCount()
        } else {
            return  viewModel.getActorsArray()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        
        searchBar.selectedScopeButtonIndex == SearchTypes.Movie ? cell.setInfo(viewModel, indexPath: indexPath) :             cell.setActorInfo(viewModel, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchBar.selectedScopeButtonIndex == SearchTypes.Movie {
            let viewmodel = DetailsViewModel(movieDetail: viewModel.getAllInfoMoview(index: indexPath.row))
            let vc = DetailsViewController(viewModel: viewmodel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constant.favoritesCellHeight
    }
}

// MARK: - Extensions Search bar

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { // solo buscara cuanso se le de click, no mientras escribe cada caracter
        searchBar.selectedScopeButtonIndex == SearchTypes.Movie ? viewModel.searchMovie(title: searchBar.text ?? "") : viewModel.searchActor(name: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.cleanMoviesArray()
            self?.tableView.reloadData()
        }
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
