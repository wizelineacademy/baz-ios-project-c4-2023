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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        interactor?.getCurrentData()
    }
    
    private func registerCells() {
        tblMovieInfo.register(UINib(nibName: CellTypes.imageTextCell.rawValue, bundle: nil), forCellReuseIdentifier: CellTypes.imageTextCell.rawValue)
    }
}

extension DetailViewController: DetailSearchDisplayLogic {
    public func updateTable(withCurrentInfo info: ImageTextTableViewProtocol?) {
        currentData = info
    }
}

extension DetailViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return configureFirstSection(forRow: indexPath)
        default:
            break
        }
        return UITableViewCell()
    }
    
    private func configureFirstSection(forRow indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblMovieInfo.dequeueReusableCell(withIdentifier: CellTypes.imageTextCell.rawValue, for: indexPath) as? ImageTextTableViewCell, let info = currentData else { return UITableViewCell() }
        cell.setInfo(info, numberOfLines: 0)
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
