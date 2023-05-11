//
//  SearchViewController.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 07/05/23.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: Variables
    var results: [SearchItem] = [] {
        didSet {
            reloadView()
        }
    }
    var networkManager = NetworkManager()
    
    // MARK: UIElements
    @IBOutlet weak var MySearchBar: UISearchBar!
    @IBOutlet weak var ResultsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ResultsCollectionView.register(UINib(nibName: "MovieAppCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "HomeViewCellId")
        
        MySearchBar.placeholder = "Movies and actors"
        MySearchBar.delegate = self
        ResultsCollectionView.dataSource = self
        ResultsCollectionView.delegate = self
    }
    
    func searchItems(using: String) {
        networkManager.getMovies(endpoint: .multi(searching: using)){(result: MultipleSearchResponse?, error) in
            if let error = error {
                print("TENEMOS ERROR EN LA CONSULTA MÚLTIPLE")
                return
            } else if let items = result?.items {
                print("TENEMOS RESPUESTA EN LA BÚSQUEDA MÚLTIPLE:")
                self.results = items
            }
        }
    }
    
    func reloadView(){
        DispatchQueue.main.async {
            self.ResultsCollectionView.reloadData()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Handle text changes in the search bar
        print("################# SEARCHING: \(searchText)...  #################")
        searchItems(using: searchText)
//        ResultsCollectionView.reloadData()
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCellId", for: indexPath) as? MovieAppCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.cellLabel.text = results[indexPath.row].title
        
        return cell
    }
    
    
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Se seleccionó el elemento name:\(results[indexPath.row].title), con id: \(results[indexPath.row].id)")
    }
}
