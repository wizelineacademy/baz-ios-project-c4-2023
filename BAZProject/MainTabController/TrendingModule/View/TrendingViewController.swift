//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

final class TrendingViewController: UITableViewController {
    
    var presenter: TrendingBarPresenterProtocol?
    let child = SpinnerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Filtro", style: .done, target: self, action: #selector(self.filterBy(sender:)))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TrendingTableViewCell")
        presenter?.willFetchMovieList()
    }
    
    @objc func filterBy(sender: UIBarButtonItem) {
        presenter?.prepareActionSheet()
    }

}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count: Int = presenter?.trendingModel.count else {
            return .zero
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") ?? UITableViewCell()
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = presenter?.trendingModel[indexPath.row].title
        config.image = UIImage(data: presenter?.trendingModel[indexPath.row].posterPath ?? Data())
        cell.contentConfiguration = config
    }

}

extension TrendingViewController: TrendingBarViewControllerProtocol {
    func reloadTendingInfo() {
        tableView.reloadData()
    }
    
    func fillTrendingList() {
        presenter?.reloadInfo()
    }
    
    func reload(with error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showAlert(withTitle title: String, withMessage message: String, withActions actions: [(String, UIAlertAction.Style)]) {
        Alerts.showActionsheet(viewController: self, title: title, message: message, actions: actions) { [weak self] index in
            self?.presenter?.search(byFilter: index)
        }
    }
    
    func showLoadingView() {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func dismissLoadingView() {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
