//
//  DetailViewController.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 26/04/23.
//

import UIKit

public protocol DetailSearchDisplayLogic: AnyObject {
    var interactor: DetailBusinessLogic? { get }
    
    func updateTable(withCurrentInfo info: CellPersonalizedTableViewProtocol?)
    func reloadCast(withCast arrCast: [CellPersonalizedTableViewProtocol])
    func reloadReviews(with arrReviews: [CellPersonalizedTableViewProtocol])
    func reloadSimilarMovies(with arrSimilar: [CellPersonalizedTableViewProtocol])
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
    private var currentData: CellPersonalizedTableViewProtocol? {
        didSet {
            navigationItem.title = currentData?.strTitle ?? ""
            tblMovieInfo.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
        }
    }
    private var arrCast: [CellPersonalizedTableViewProtocol]? {
        didSet {
            tblMovieInfo.reloadSections(IndexSet(arrayLiteral: 1), with: .automatic)
        }
    }
    private var arrReviews: [CellPersonalizedTableViewProtocol]? {
        didSet {
            tblMovieInfo.reloadSections(IndexSet(arrayLiteral: 2), with: .automatic)
        }
    }
    private var arrSimilar: [CellPersonalizedTableViewProtocol]? {
        didSet {
            tblMovieInfo.reloadSections(IndexSet(arrayLiteral: 3), with: .automatic)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        interactor?.getCurrentData()
    }
    
    private func registerCells() {
        var nib = UINib(nibName: CellTypes.imageTextCell.rawValue, bundle: nil)
        tblMovieInfo.register(nib, forCellReuseIdentifier: CellTypes.imageTextCell.rawValue)
        
        nib = UINib(nibName: CellTypes.reviewCell.rawValue, bundle: nil)
        tblMovieInfo.register(nib, forCellReuseIdentifier: CellTypes.reviewCell.rawValue)
    }
}

extension DetailViewController: DetailSearchDisplayLogic {
    public func updateTable(withCurrentInfo info: CellPersonalizedTableViewProtocol?) {
        currentData = info
    }
    
    public func serviceDidFailed(with strMessage: String) {
        let alert = UIAlertController(title: "", message: strMessage, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: NSLocalizedString("Accept", comment: "Accept"), style: .default)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
    
    public func reloadCast(withCast arrCast: [CellPersonalizedTableViewProtocol]) {
        self.arrCast = arrCast
    }
    
    public func reloadReviews(with arrReviews: [CellPersonalizedTableViewProtocol]) {
        self.arrReviews = arrReviews
    }
    
    public func reloadSimilarMovies(with arrSimilar: [CellPersonalizedTableViewProtocol]) {
        self.arrSimilar = arrSimilar
    }
    
}

extension DetailViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return NSLocalizedString("Cast", comment: "Cast")
        case 2:
            return NSLocalizedString("Reviews", comment: "Reviews")
        case 3:
            return NSLocalizedString("Similar movies", comment: "")
        default:
            return nil
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return arrCast?.count ?? 0
        case 2:
            return arrReviews?.count ?? 0
        case 3:
            return arrSimilar?.count ?? 0
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return configure(forMovie: currentData, andRow: indexPath)
        case 1:
            let cast = arrCast?[indexPath.row]
            return configure(forMovie: cast, andRow: indexPath)
        case 2:
            let review = arrReviews?[indexPath.row]
            return configure(forReview: review, andIndexPath: indexPath)
        case 3:
            let movie = arrSimilar?[indexPath.row]
            return configure(forMovie: movie, andRow: indexPath)
        default:
            break
        }
        return UITableViewCell()
    }
    
    private func configure(forMovie movie: CellPersonalizedTableViewProtocol?, andRow indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblMovieInfo.dequeueReusableCell(withIdentifier: CellTypes.imageTextCell.rawValue, for: indexPath) as? ImageTextTableViewCell, let movie = movie else { return UITableViewCell() }
        cell.setInfo(movie, numberOfLines: indexPath.section == 0 ? 0 : 2)
        return cell
    }
    
    private func configure(forReview review: CellPersonalizedTableViewProtocol?, andIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblMovieInfo.dequeueReusableCell(withIdentifier: CellTypes.reviewCell.rawValue, for: indexPath) as? ReviewTableViewCell, let review = review else { return UITableViewCell() }
        cell.set(info: review)
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
