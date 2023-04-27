//
//  DetailViewController.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 26/04/23.
//

import UIKit

public protocol DetailSearchDisplayLogic: AnyObject {
    var interactor: DetailBusinessLogic? { get }
    
    func updateTable(withCurrentInfo info: ImageTextTableViewProtocol?)
    func reloadSimilarMovies(with arrSimilar: [ImageTextTableViewProtocol])
    func serviceDidFailed(with strMessage: String)
}

public class DetailViewController: UIViewController {
    @IBOutlet public weak var tblMovieInfo: UITableView!{
        didSet {
            tblMovieInfo.delegate = self
            tblMovieInfo.dataSource = self
        }
    }
    public var interactor: DetailBusinessLogic?
    private var currentData: ImageTextTableViewProtocol? {
        didSet {
            navigationItem.title = currentData?.strTitle ?? ""
            tblMovieInfo.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
        }
    }
    private var arrSimilar: [ImageTextTableViewProtocol]?{
        didSet {
            tblMovieInfo.reloadSections(IndexSet(arrayLiteral: 2), with: .automatic)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        interactor?.getCurrentData()
        interactor?.searchForSimilar()
    }
    
    private func registerCells() {
        tblMovieInfo.register(UINib(nibName: CellTypes.imageTextCell.rawValue, bundle: nil), forCellReuseIdentifier: CellTypes.imageTextCell.rawValue)
    }
}

extension DetailViewController: DetailSearchDisplayLogic {
    public func updateTable(withCurrentInfo info: ImageTextTableViewProtocol?) {
        currentData = info
    }
    
    public func serviceDidFailed(with strMessage: String) {
        let alert = UIAlertController(title: "", message: strMessage, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: NSLocalizedString("Accept", comment: "Accept"), style: .default)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
    
    public func reloadSimilarMovies(with arrSimilar: [ImageTextTableViewProtocol]) {
        self.arrSimilar = arrSimilar
    }
}

extension DetailViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 2:
            return NSLocalizedString("Similar movies", comment: "")
        default:
            return nil
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 2:
            return arrSimilar?.count ?? 0
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return configure(forMovie: currentData, andRow: indexPath)
        case 2:
            let movie = arrSimilar?[indexPath.row]
            return configure(forMovie: movie, andRow: indexPath)
        default:
            break
        }
        return UITableViewCell()
    }
    
    private func configure(forMovie movie: ImageTextTableViewProtocol?, andRow indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblMovieInfo.dequeueReusableCell(withIdentifier: CellTypes.imageTextCell.rawValue, for: indexPath) as? ImageTextTableViewCell, let movie = movie else { return UITableViewCell() }
        cell.setInfo(movie, numberOfLines: indexPath.section == 0 ? 0 : 2)
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
