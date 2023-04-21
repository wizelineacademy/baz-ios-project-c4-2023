//
//  ResultsTableController.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 20/04/23.
//

import UIKit

class ResultsTableController: UITableViewController {
    
    @IBOutlet weak var resultsLabel: UILabel!

    let tableViewCellIdentifier = "cellID"
    
    var filteredProducts: [ListMovieProtocol] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "TableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: tableViewCellIdentifier)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        let movie = filteredProducts[indexPath.row]
        
        cell.textLabel?.text = movie.title
        guard let url = URL(string: ApiConstans.baseUrlImage + movie.posterPath) else { return UITableViewCell()}
        UIImage().loadFrom(url: url) { image in
            DispatchQueue.main.async {
                cell.imageView?.image = image
            }
        }
        return cell
    }

}
