//
//  TrendingView.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
//  
//

import Foundation
import UIKit

class TrendingView: UIViewController {

    // MARK: Properties
    var presenter: TrendingPresenterProtocol?
    @IBOutlet weak var tblMovies: UITableView! {
        didSet {
            tblMovies.dataSource = self
            tblMovies.delegate = self
        }
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension TrendingView: TrendingViewProtocol {
    func setNavigationTitle(for strTitle: String?) {
        navigationItem.title = strTitle
    }
    
    func registerXIB() {
        let nib = UINib(nibName: CellTypes.imageTextCell.rawValue, bundle: nil)
        tblMovies.register(nib, forCellReuseIdentifier: CellTypes.imageTextCell.rawValue)
    }
    
    func reloadTable() {
        tblMovies.reloadData()
    }
}

extension TrendingView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellTypes.imageTextCell.rawValue, for: indexPath) as? ImageTextTableViewCell, let movie = presenter?.getMovie(forRow: indexPath.row) {
            cell.setInfo(movie)
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension TrendingView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
