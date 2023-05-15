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
    func showResults(in arrCellInfo: [CellPersonalizedTableViewProtocol])
}

public class SearchViewController: UIViewController {
    public var interactor: SearchBusinessLogic?
    private var arrCellInfo: [CellPersonalizedTableViewProtocol]? {
        didSet {
            tblResults.reloadData()
        }
    }
    @IBOutlet public weak var txfSearch: UITextField! {
        didSet {
            txfSearch.placeholder = NSLocalizedString("Search by movie or artist", comment: "Search by movie or artist")
            txfSearch.delegate = self
        }
    }
    @IBOutlet public weak var lblErrorMessage: UILabel! {
        didSet {
            lblErrorMessage.text = ""
        }
    }
    @IBOutlet public weak var tblResults: UITableView! {
        didSet {
            tblResults.dataSource = self
            tblResults.delegate = self
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tblResults.register(UINib(nibName: CellTypes.imageTextCell.rawValue, bundle: nil), forCellReuseIdentifier: CellTypes.imageTextCell.rawValue)
    }
    
    @IBAction func buttonSearchTapped(_ sender: Any) {
        txfSearch.resignFirstResponder()
        interactor?.search(withParams: txfSearch.text)
    }
}

extension SearchViewController: SearchDisplayLogic {
    public func placeInLabel(message strMessage: String) {
        lblErrorMessage.text = strMessage
    }
    
    public func showResults(in arrCellInfo: [CellPersonalizedTableViewProtocol]) {
        self.arrCellInfo = arrCellInfo
    }
}

extension SearchViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCellInfo?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let arrCellInfo = arrCellInfo, arrCellInfo.count > 0, let cell = tableView.dequeueReusableCell(withIdentifier: CellTypes.imageTextCell.rawValue, for: indexPath) as? ImageTextTableViewCell else { return UITableViewCell() }
        let info = arrCellInfo[indexPath.row]
        cell.setInfo(info)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let info = arrCellInfo?[indexPath.row] as? Movie {
            let destinationVC = CleanFactory.createDetailModule(withMovie: info)
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        placeInLabel(message: "")
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buttonSearchTapped(textField)
        return true
    }
}
