//
//  SearchView.swift
//  BAZProject
//
//  Created by Manuel S on 18/04/23.
//

import UIKit

class SearchView: UIViewController {
    
    var viewModel: SearchViewModel = SearchViewModel()// se crea instancia al ViewModel de MVVM
     
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        configureView()
    }
/// Configuracion necesaria para la vista
    func configureView() {
        self.title = "Buscar"
        searchBar.showsCancelButton = true
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        viewModel.bindMovies { [weak self] in // Bind para relacionar Vista con ViewModel
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.searchMovie("") { [weak self] (error) in
            DispatchQueue.main.async {
                guard let error = error else { return }
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert, animated: false)
            }
        }
    }
}

//MARK: - Extensions
extension SearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getMovieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell? ?? UITableViewCell()
        cell.textLabel?.text = viewModel.getTitle(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewmodel = DetailsViewModel(movieDetail: viewModel.getAllInfoMoview(index: indexPath.row))
        let vc = DetailsView(ViewModel: viewmodel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { // solo buscara cuanso se le de click, no mientras escribe cada caracter
        viewModel.searchMovie(searchBar.text ?? "") { [weak self] (error) in
            DispatchQueue.main.async {
                guard let error = error else { return }
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert, animated: false)
            }
        }
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
