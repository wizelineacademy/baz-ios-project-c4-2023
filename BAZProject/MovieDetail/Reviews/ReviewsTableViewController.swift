//
//  ReviewsTableViewController.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import UIKit

///ViewController que despliega los resultados de las reseñas de una pelicuila
final class ReviewsTableViewController: UITableViewController {
    ///Arreglo que contiene las reseñas de una pelicula
    var reviews: [Review] = []{
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reseñas"
        self.tableView.register(UINib(nibName: ReviewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ReviewTableViewCell.identifier)
        self.tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        let review = reviews[indexPath.row]
        let autor = review.authorDetails
        
        guard let url = autor.urlAvatar else { return UITableViewCell() }
        cell.imageAuthor.loadRemoteImage(url: url)
        cell.lblAuthorName.text = autor.username
        cell.lblReview.text = review.content
        cell.lblDescription.text = "Rating: \(autor.rating ?? 0.0)"
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    static var identifier: String{
        return String(describing: self)
    }
}
