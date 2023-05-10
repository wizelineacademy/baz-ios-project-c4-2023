//
//  SearchPresenterMock.swift
//  BAZProjectTests
//
//  Created by Ben Frank V. on 25/04/23.
//

import UIKit

class SearchPresenterMock  {
    
    // MARK: Properties
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?
    
    
    var entity = SearchEntity()
    var tableView: UITableView = UITableView()
    
    init(view: SearchViewProtocol? = nil, interactor: SearchInteractorMock? = nil, router: SearchRouterProtocol? = nil, entity: SearchEntity = SearchEntity(), tableView: UITableView) {
        self.view = view
        self.interactor = SearchInteractorMock()
        self.router = router
        self.entity = entity
        self.tableView = tableView
    }
    
}

extension SearchPresenterMock : SearchPresenterProtocol {
    
    func viewDidLoad() {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entity.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GeneralTableViewCell.identifier, for: indexPath) as? GeneralTableViewCell{
            let movie = entity.result?[indexPath.row]
            cell.setup(movie)
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }
    
    
    func willFetchMovies(_ movie: String) {
        interactor?.fetchMovies(movie)
    }
}

extension SearchPresenterMock : SearchInteractorOutputProtocol {
    
    func onReceivedSearchedMovies(_ result: [Movie]) {
        entity.result = result
        
    }
    
    func showSearchedMoviesError(_ error: Error) {
        print(error)
    }
}
