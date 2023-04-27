//  HomeViewController.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.

import UIKit

//MARK: - Class
class HomeViewController: UIViewController, UITableViewDelegate {
    //MARK: - Properties
    private lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    var presenter: HomeViewOutputProtocol?
    private var moviesModel: [MovieResult]?
    {
        didSet {
            self.movieTableView.reloadData()
        }
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.movieTableView.register(HomeCell.self, forCellReuseIdentifier: CellConstants.cellID)
        presenter?.getDataMovies(endPoint: .trending)
        let exitButtom: UIBarButtonItem
        exitButtom = UIBarButtonItem(title: LocalizableString.searchTitle.localized,
                                     style: .plain,
                                     target: self,
                                     action: #selector(gotoSerch))
        navigationItem.setRightBarButton(exitButtom,
                                         animated: false)
        title = LocalizableString.labelTitle.localized
        addTableView()
        setupTableView()
    }
    
    // MARK: Functions
    @objc public func gotoSerch() {
        let viewController = SearchRouter.createModule()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func addTableView() {
        self.view.addSubview(movieTableView)
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(HomeCell.self, forCellReuseIdentifier: CellConstants.cellID)
    }

}

//MARK: - Extensions
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.cellID, for: indexPath) as? HomeCell
        else { return UITableViewCell() }
        cell.setupTitle(title: self.moviesModel?[indexPath.row].title ?? "")
        self.presenter?.getMovieImage(index: indexPath.row, completion: { image in
            let imgDefault = UIImage(named: "poster") ?? UIImage()
            cell.setupImage(image: (image ?? imgDefault))
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - P R E S E N T E R · T O · V I E W
extension HomeViewController: HomeViewInputProtocol {
    func showViewDataMovies(movies: [ListMovieProtocol]?) {
        self.moviesModel = movies as? [MovieResult]
    }
}
