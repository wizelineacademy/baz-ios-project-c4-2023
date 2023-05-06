//
//  MovieDetailViewController.swift
//  BAZProject
//
//  Created by jmgarciaca on 18/04/23.
//

import UIKit

// MARK: - MovieDetailViewController
final class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var movieVM: MovieViewModel?
    private let imageLoader: ImageLoader = ImageLoader()
    
    // MARK: - Outlets
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblVote: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar(largeTitleColor: .white, backgoundColor: UIColor(named: "background") ?? .white, tintColor: .white, title: movieVM?.title ?? "Detail", preferredLargeTitle: true)
        
        setupView()
    }
}

extension MovieDetailViewController {

    func setupView() {
        
        lblTitle.text = movieVM?.title
        lblOverview.text = movieVM?.overview
        lblVote.text = movieVM?.vote_average
        lblYear.text = movieVM?.year
        
        if let url = URL(string: movieVM?.poster_path ?? "") {
            imageLoader.getImage(from: url) { [weak self] image in
                self?.imgView.image = image
            }
        }
    }
    
}
