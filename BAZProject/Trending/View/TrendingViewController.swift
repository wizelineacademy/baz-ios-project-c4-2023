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
        if let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier, for: indexPath) as? TrendingTableViewCell{
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = entity?.result?[indexPath.row].title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }

}

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
        tableView.register(UINib(nibName: TrendingTableViewCell.identifier, bundle : nil), forCellReuseIdentifier: TrendingTableViewCell.identifier)
    }
    
}
