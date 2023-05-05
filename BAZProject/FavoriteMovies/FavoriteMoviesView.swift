//
//  FavoriteMoviesView.swift
//  BAZProject
//
//  Created by Carlos Garcia on 04/05/23.
//

import UIKit

class FavoriteMoviesView: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var labelEmptyResult: UILabel! {
        didSet {
            labelEmptyResult.isHidden = true
        }
    }
    
    // MARK: Properties
    var presenter: FavoriteMoviesPresenterProtocol?
    
    // MARK: Init
    init(presenter: FavoriteMoviesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadMovies()
    }
    
    private func configView() {
        tableView.register(UINib(nibName: MovieListCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: MovieListCell.reusableIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func reloadFavoriteList() {
        if (presenter?.numberOfRows() ?? 0) == 0 {
            labelEmptyResult.isHidden = false
        }
        tableView.reloadData()
    }
}

extension FavoriteMoviesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.reusableIdentifier) as? MovieListCell,
            let movieInfo = presenter?.getMovie(for: indexPath)
        else {
            return UITableViewCell()
        }
        movieCell.setData(with: movieInfo)
        return movieCell
    }
}

extension FavoriteMoviesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToMovieDetails(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

extension FavoriteMoviesView: FavoriteMoviesViewProtocol {
    func setNavigationTitle(for strTitle: String?) {
        navigationItem.title = strTitle
    }
    
    func updateMovies() {
        self.reloadFavoriteList()
    }
}
