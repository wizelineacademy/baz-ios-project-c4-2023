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
    @IBOutlet weak var actorsCV: UICollectionView!
    @IBOutlet weak var similarCV: UICollectionView!
    @IBOutlet weak var recomendationsCV: UICollectionView!


    init(ViewModel: DetailsViewModel) {
        self.ViewModel = ViewModel
        super.init(nibName: "DetailsView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let nib = UINib(nibName: "DetailsCollectionViewCell", bundle: nil)
        
        actorsCV.register(nib, forCellWithReuseIdentifier: "cell")
        similarCV.register(nib, forCellWithReuseIdentifier: "cell")
        recomendationsCV.register(nib , forCellWithReuseIdentifier: "cell")

        //TODO: mandar a llamar todas las peticiones
        //dispatch Group
        //Loader
        titleLabel.text = ViewModel.movieDetail.value.title
        imageMovie.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(ViewModel.movieDetail.value.poster_path ?? "")")!)
        overviewText.text = ViewModel.movieDetail.value.overview
        voteAverage.text = "\(ViewModel.movieDetail.value.vote_average ?? 0.0)"
        
    }
}


extension DetailsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case actorsCV:
            return 3
        case similarCV:
            return 5
        case recomendationsCV:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DetailsCollectionViewCell
        switch collectionView {
        case actorsCV:
            cell.txtLabel.text = "Holi"
            cell.imageView.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(ViewModel.movieDetail.value.poster_path ?? "")")!)
            return cell
        case similarCV:
            cell.backgroundColor = .blue
            return cell
        case recomendationsCV:
            cell.backgroundColor = .yellow
            return cell
        default:
            return cell
        }
    }
}
