//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit
import Foundation

class TrendingViewController: UITableViewController {
    
    var trendingModel: MovieListProtocol = TrendingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingModel.getDataMovies {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - TableView's DataSource

extension TrendingViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingModel.getRowCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") ?? UITableViewCell()
    }
    
}

// MARK: - TableView's Delegate

extension TrendingViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let imageLoader: ImageLoader = ImageLoader()
        var config = UIListContentConfiguration.cell()
        config.text = trendingModel.getTitle(index: indexPath.row)
        if let imageUrl = URL(string: trendingModel.getPosterPath(index: indexPath.row) ?? "") {
            imageLoader.loadIamge(from: imageUrl) { image in
                config.image = image
                cell.contentConfiguration = config
            }
        } else {
            config.image = UIImage(named: "poster")
        }
        cell.contentConfiguration = config
    }
    
}
