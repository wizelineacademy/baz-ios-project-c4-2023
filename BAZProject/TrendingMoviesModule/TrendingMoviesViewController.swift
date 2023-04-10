//
//  TrendingMoviesViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingMoviesViewController: UIViewController {
    
    lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TrendingTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var model: TrendingMoviesViewModel?
    
    static func getInstance(with model: TrendingMoviesViewModel) -> TrendingMoviesViewController {
        let vc = TrendingMoviesViewController()
        vc.title = "Trending"
        vc.tabBarItem = UITabBarItem(title: vc.title, image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
        vc.model = model
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewContstraints()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        view.backgroundColor = .systemBackground
        Task {
            do {
                try await model?.getMovies()
                self.moviesTableView.reloadData()
            } catch {
                presentError(message: error.localizedDescription)
            }
        }
    }
    
    private func setTableViewContstraints() {
        view.addSubview(moviesTableView)
        moviesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        moviesTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        moviesTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    }
    
    private func presentError(message: String) {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }

}

// MARK: - TableView's DataSource

extension TrendingMoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.getRowCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") ?? UITableViewCell()
    }

}

// MARK: - TableView's Delegate

extension TrendingMoviesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = model?.getCellConfiguration(row: indexPath.row) ?? UIListContentConfiguration.cell()
        config.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        cell.indentationLevel = 1
        cell.indentationWidth = 0
        config.image = UIImage(named: "poster") ?? UIImage(systemName: "photo")
        cell.contentConfiguration = config
    }

}
