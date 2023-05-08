//
//  ResultsTableController.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 20/04/23.
//

import UIKit

protocol ResultTableForMoviesProtocol{
    var filteredProducts: [ListMovieProtocol] { get set}
    var tableViewCellIdentifier: String { get set }
    var delegate: ResultTableForMoviesDelegate? { get set}
}

protocol ResultTableForMoviesDelegate{
    func didSelectMovie(_ moview: Movie)
}

///ViewController que despliega los resultados de una busqueda

final class ResultsTableController: UITableViewController, ResultTableForMoviesProtocol {
    
    ///UILabel que muestra el total de elementos que tiene la busqueda
    @IBOutlet weak var resultsLabel: UILabel!
    
    var delegate: ResultTableForMoviesDelegate?
    ///Idetificador de la celda
    var tableViewCellIdentifier = "cellID"
    ///Arreglo de ListMovieProtocol  que contiene los resultados a desplegar de la busqueda
    var filteredProducts: [ListMovieProtocol] = []{
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.resultsLabel.text = "Número de elementos encontrados: \(self?.filteredProducts.count ?? 0)"
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "TableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: tableViewCellIdentifier)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        let movie = filteredProducts[indexPath.row]
        cell.textLabel?.text = movie.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = filteredProducts[indexPath.row] as? Movie else { return }
        delegate?.didSelectMovie(movie)
        self.navigationController?.popViewController(animated: true)
    }

}
