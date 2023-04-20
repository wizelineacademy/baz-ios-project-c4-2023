//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

final class TrendingViewController: UITableViewController {

    var trendingModel: MoviesListProtocol = TrendingViewModel() // protocolo para para poder realizar Testing

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    /// se guarda la respuesta del servicio en el arreglo y se recarga la tabla
    func getMovieArray() {
        trendingModel.getmovies()
    }
    
    ///Configuracion para cuando se cargue la vista
    func setView() {
        self.tabBarController?.viewControllers?[1].title = "Buscar"
        trendingModel.bindMovies { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        getMovieArray()
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trendingModel.getMovieCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }
}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = trendingModel.getTitle(index: indexPath.row)
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }
}
