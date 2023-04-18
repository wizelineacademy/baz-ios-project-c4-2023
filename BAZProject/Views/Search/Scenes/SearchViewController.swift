//
//  SearchViewController.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 16/04/23.
//

import UIKit

public protocol SearchDisplayLogic: AnyObject {
    var interactor: SearchBusinessLogic? { get }
    
    func placeInLabel(message strMessage: String)
    func showResults(in arrCellInfo: [ImageTextTableViewProtocol])
}

class SearchViewController: UIViewController {

    var interactor: SearchBusinessLogic?
    weak var router: SearchRouter?
    private var arrCellInfo: [ImageTextTableViewProtocol]?{
        didSet {
            tblResults.reloadData()
        }
    }
    
    @IBOutlet weak var txfSearch: UITextField!{
        didSet{
            txfSearch.placeholder = NSLocalizedString("Search by movie or artist", comment: "Search by movie or artist")
        }
    }
    @IBOutlet weak var lblErrorMessage: UILabel! {
        didSet {
            lblErrorMessage.text = ""
        }
    }
    
    @IBOutlet weak var tblResults: UITableView! {
        didSet {
            tblResults.dataSource = self
            tblResults.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblResults.register(UINib(nibName: CellTypes.imageTextCell.rawValue, bundle: nil), forCellReuseIdentifier: CellTypes.imageTextCell.rawValue)
    }
    
    @IBAction func buttonSearchTapped(_ sender: Any) {
        interactor?.search(withParams: txfSearch.text)
    }
    
}

extension SearchViewController: SearchDisplayLogic {
    
    func placeInLabel(message strMessage: String) {
        lblErrorMessage.text = strMessage
    }
    
    func showResults(in arrCellInfo: [ImageTextTableViewProtocol]) {
        self.arrCellInfo = arrCellInfo
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCellInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let arrCellInfo = arrCellInfo, arrCellInfo.count > 0, let cell = tableView.dequeueReusableCell(withIdentifier: CellTypes.imageTextCell.rawValue, for: indexPath) as? ImageTextTableViewCell else { return UITableViewCell() }
        let info = arrCellInfo[indexPath.row]
        cell.setInfo(info)
        return cell
    }
    
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
