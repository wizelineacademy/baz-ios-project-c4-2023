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
        trendingModel.getmovies(category: .Trending)
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
    
    //MARK: - Buttons
    @IBAction func FilterButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Filtro", message: "Selecciona el filtro que quieres aplicar", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: categoriesFilter.Trending.rawValue, style: UIAlertAction.Style.default) { [weak self] _ in
            self?.navigationItem.title = categoriesFilter.Trending.rawValue
            self?.trendingModel.getmovies(category: .Trending)
        })
        alert.addAction(UIAlertAction(title: categoriesFilter.NowPlaying.rawValue, style: UIAlertAction.Style.default) { [weak self] _ in
            self?.navigationItem.title = categoriesFilter.NowPlaying.rawValue
            self?.trendingModel.getmovies(category: .NowPlaying)
        })
        alert.addAction(UIAlertAction(title: categoriesFilter.Popular.rawValue, style: UIAlertAction.Style.default) {[weak self] _ in
            self?.navigationItem.title = categoriesFilter.Popular.rawValue
            self?.trendingModel.getmovies(category: .Popular)
        })
        alert.addAction(UIAlertAction(title: categoriesFilter.TopRated.rawValue, style: UIAlertAction.Style.default) { [weak self] _ in
            self?.navigationItem.title = categoriesFilter.TopRated.rawValue
            self?.trendingModel.getmovies(category: .TopRated)
        })
        alert.addAction(UIAlertAction(title: categoriesFilter.Upcoming.rawValue, style: UIAlertAction.Style.default) { [weak self] _ in
            self?.navigationItem.title = categoriesFilter.Upcoming.rawValue
            self?.trendingModel.getmovies(category: .Upcoming)
        })
        self.present(alert, animated: true, completion: nil)
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
