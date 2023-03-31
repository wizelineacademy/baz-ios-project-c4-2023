//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {

    var movies: [Movie] = []
    private lazy var serviceApi = ServiceApi(serviceDelegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        serviceApi.search(forPath: "/trending/movie/day")
        
    }

}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }

}

extension TrendingViewController : ServiceApiProtocol{
    func serviceFinished(withResult result: Result<[String : Any], ErrorApi>) {
        switch result {
        case .success(let success):
            configureMovies(fromResponse: success)
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    private func configureMovies(fromResponse dctResponse : [String : Any]){
        guard let results = dctResponse["results"] as? [[String : Any]] else { return }
        for result in results {
            if let id = result["id"] as? Int,
               let title = result["title"] as? String,
               let poster_path = result["poster_path"] as? String {
                movies.append(Movie(id: id, title: title, poster_path: poster_path))
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
