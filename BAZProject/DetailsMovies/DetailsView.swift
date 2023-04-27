//
//  DetailsView.swift
//  BAZProject
//
//  Created by Manuel S on 26/04/23.
//

import UIKit

class DetailsView: UIViewController {
    
    var ViewModel: DetailsViewModel
    
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet weak var voteAverage: UILabel!

    init(ViewModel: DetailsViewModel) {
        self.ViewModel = ViewModel
        super.init(nibName: "DetailsView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //TODO: mandar a llamar todas las peticiones
        //dispatch Group
        //Loader
        titleLabel.text = ViewModel.movieDetail.value.title
        imageMovie.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(ViewModel.movieDetail.value.poster_path ?? "")")!)
        overviewText.text = ViewModel.movieDetail.value.overview
        voteAverage.text = "\(ViewModel.movieDetail.value.vote_average ?? 0.0)"
        
    }
    
}
