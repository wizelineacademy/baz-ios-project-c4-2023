//  HomeViewController.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.

import UIKit

//MARK: - Class
final class HomeViewController: UITableViewController {
    //MARK: - Properties
    var presenter: HomeViewOutputProtocol?
    private var moviesModel: [MovieResult]?
    {
        didSet {
            self.tableView.reloadData()
        }
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.cellID)
        presenter?.getDataMovies()
        let exitButtom: UIBarButtonItem
        exitButtom = UIBarButtonItem(title: LocalizableString.searchTitle.localized,
                                     style: .plain,
                                     target: self,
                                     action: #selector(gotoSerch))
        navigationItem.setRightBarButton(exitButtom,
                                         animated: false)
        title = LocalizableString.labelTitle.localized
    }
    
    // MARK: Functions
    @objc public func gotoSerch() {
        let viewController = SearchRouter.createModule()
        navigationController?.pushViewController(viewController, animated: true)
    }

}

//MARK: - Extensions
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesModel?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.cellID, for: indexPath) as? HomeCell else { return UITableViewCell() }
        cell.setupTitle(title: self.moviesModel?[indexPath.row].title ?? "")
        self.presenter?.getMovieImage(index: indexPath.row, completion: { image in
            let imgDefault = UIImage(named: "poster") ?? UIImage()
            cell.setupImage(image: (image ?? imgDefault))
        })
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}

// MARK: - P R E S E N T E R · T O · V I E W
extension HomeViewController: HomeViewInputProtocol {
    func showViewDataMovies(movies: [ListMovieProtocol]?) {
        self.moviesModel = movies as? [MovieResult]
    }
}
