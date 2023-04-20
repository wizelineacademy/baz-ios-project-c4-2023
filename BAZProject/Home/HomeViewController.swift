//  HomeViewController.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.

import UIKit

//MARK: - Class
class HomeViewController: UITableViewController {
    //MARK: - Properties
    var presenter: HomeViewOutputProtocol?
    private var model: [MovieResult]?
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
        
        exitButtom = UIBarButtonItem(title: "Search",
                                     style: .plain,
                                     target: self,
                                     action: #selector(gotoSerch))
        navigationItem.setRightBarButton(exitButtom,
                                                animated: false)
    }
    
    @objc open func gotoSerch() {
        print("Saludos")
    }

}

//MARK: - Extensions
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.cellID, for: indexPath) as? HomeCell else { fatalError("Unabel to create cell")}
        
        cell.setupTitle(title: self.model?[indexPath.row].title ?? "")
        
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
        self.model = movies as? [MovieResult]
    }
    
}
