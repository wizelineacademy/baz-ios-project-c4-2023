//
//  MovieDetailsView.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//  
//

import Foundation
import UIKit

class MovieDetailsView: UIViewController {
    
    @IBOutlet private weak var imgVwBackgroundCover: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblOverview: UILabel!
    @IBOutlet private weak var lblCast: UILabel!

    // MARK: Properties
    var presenter: MovieDetailsPresenterProtocol?
    
    init(presenter: MovieDetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension MovieDetailsView: MovieDetailsViewProtocol {
    func showMovieData(_ movie: MovieInfo) {
        lblTitle.text = movie.title
        lblOverview.text = movie.overview
        lblCast.text = "Actor 1, Actor 2, Actor 3... más"
        
        self.imgVwBackgroundCover.image = UIImage(named: "poster")
        guard let strBackdropPath = movie.backdropPath else { return }
        ResourcesManager().downloadImage(from: strBackdropPath) { image in
            if let image = image {
                self.imgVwBackgroundCover.image = image
            }
        }
    }
    
    func setNavigationTitle(for strTitle: String?){
        navigationItem.title = strTitle
    }
}
