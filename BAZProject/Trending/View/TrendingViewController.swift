//
//  TrendingViewController.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//

import UIKit

class TrendingViewController: UITableViewController {
    
    var presenter: TrendingPresenterProtocol?
    var entity: TrendingEntity?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshDetail()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
    }
    
    func refreshDetail(){
        presenter?.willFetchMovies()
    }

}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entity?.result?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GeneralTableViewCell.identifier, for: indexPath) as? GeneralTableViewCell{
            let movie = entity?.result?[indexPath.row]
            cell.setup(movie)
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController: TrendingViewProtocol {
    // TODO: implement view output methods
    func setNavigationTitle(for strTitle: String?){
        navigationItem.title = strTitle
    }
    
    func updateData(with result: [Movie]) {
        self.entity?.result = result
    }
    
    func updataView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func registrerCell(){
        tableView.register(UINib(nibName: GeneralTableViewCell.identifier, bundle : nil), forCellReuseIdentifier: GeneralTableViewCell.identifier)
    }
    
}
