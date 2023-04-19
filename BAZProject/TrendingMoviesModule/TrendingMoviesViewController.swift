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
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    var model: TrendingMoviesViewModel
    
    init(model: TrendingMoviesViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        self.title = "Trending"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
        self.bindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setTableView()
        loadData()
    }
    
    // MARK: - ViewModel Calls
    private func loadData() {
        Task {
            do {
                try await model.getMovies()
            } catch {
                presentError(message: error.localizedDescription)
            }
        }
    }
    
    private func bindings() {
        model.bindMovies { [weak self] in
            DispatchQueue.main.async {
                self?.moviesTableView.reloadData()
            }
        }
    }
    
    // MARK: - Visuals
    private func setView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setTableView() {
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
        return model.getRowCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") ?? UITableViewCell()
    }

}

// MARK: - TableView's Delegate

extension TrendingMoviesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = model.getCellConfiguration(row: indexPath.row)
        config.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        cell.indentationLevel = 1
        cell.indentationWidth = 0
        config.image = UIImage(named: "poster") ?? UIImage(systemName: "photo")
        cell.contentConfiguration = config
    }

}
