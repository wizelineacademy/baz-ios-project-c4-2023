//
//  SearchPresenter.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation
import UIKit

class SearchPresenter  {
    
    // MARK: Properties
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?
    
    var entity = SearchEntity()
    var tableView: UITableView = UITableView()
    
}

extension SearchPresenter: SearchPresenterProtocol {
    func viewDidLoad() {
        view?.setNavigationTitle(for: interactor?.getNavTitle())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entity.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier, for: indexPath) as? TrendingTableViewCell{
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        //config.text = entity.result?[indexPath.row].title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }
    
    
    
    func willFetchMovies(_ movie: String) {
        interactor?.fetchMovies(movie)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func onReceivedSearchedMovies(_ result: [SearchedMovies]) {
        self.entity.result = result
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func showSearchedMoviesError(_ error: Error) {
        print(error)
    }
}
