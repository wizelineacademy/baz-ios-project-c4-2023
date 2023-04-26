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
    
    func loadImage(from url: URL?, withCompletionHandler handler: @escaping (UIImage?) -> Void) -> URLSessionDownloadTask? {
            guard let url = url else { return nil }
            let downloadTask = URLSession.shared.downloadTask(with: url) { [weak self] url, response, error in
                if let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        handler(image)
                    }
                }
            }
            
            downloadTask.resume()
            return downloadTask
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
        let _ = loadImage(from: URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")) { image in
            config.image = image
        }
        cell.contentConfiguration = config
    }
}
