//
//  MovieDetailViewController.swift
//  BAZProject
//
//  Created by jmgarciaca on 18/04/23.
//

import UIKit

/// This class represents the movie detail view controller, responsible for displaying the details of a movie.
final class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    /// The view model of the movie.
    var movieVM: MovieViewModel?
    
    /// The image loader used to load the movie poster image.
    private let imageLoader: ImageLoader = ImageLoader()
    
    // MARK: - Outlets
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblVote: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblCast: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var vwReview: UIView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar(largeTitleColor: .white, backgoundColor: UIColor(named: "background") ?? .white, tintColor: .white, title: movieVM?.title ?? "Detail", preferredLargeTitle: true)
        
        setupView()
    }
}

extension MovieDetailViewController {

    /// Sets up the view with the movie details.
    func setupView() {
        
        lblTitle.text = movieVM?.title
        lblVote.text = movieVM?.vote_average
        lblYear.text = movieVM?.year
        lblOverview.text = movieVM?.overview
        
        if let url = URL(string: movieVM?.poster_path ?? "") {
            imageLoader.getImage(from: url) { [weak self] image in
                self?.imgView.image = image
            }
        }
        
        movieVM?.loadCast { actors in
            self.lblCast.text = actors
        }
        
        movieVM?.loadReviews { [weak self] reviews in
            for review in reviews {
                guard let view = UserReview.instanceFromNib(review) else { continue }
                self?.vwReview.addSubview(view)
            }
        }
    }
}
