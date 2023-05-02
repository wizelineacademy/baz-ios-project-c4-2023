//
//  MovieDetailViewController.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 27/04/23.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var presenter: MovieDetailPresenterProtocol?
    
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieOverview: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.notifyViewLoaded()
        // Do any additional setup after loading the view.
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.lblMovieTitle.text = self.presenter?.movieDetail?.title ?? ""
            self.lblMovieOverview.text = self.presenter?.movieDetail?.overview ?? ""
        }
        if let posterPath = self.presenter?.movieDetail?.posterPath, let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            imageURL.toImage() { image in
                DispatchQueue.main.async {
                    self.MovieImage.image = image
                }
            }
        } else {
        }
    }
    
}
