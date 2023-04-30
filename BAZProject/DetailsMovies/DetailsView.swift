//
//  DetailsView.swift
//  BAZProject
//
//  Created by Manuel S on 26/04/23.
//

import UIKit

class DetailsView: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    //MARK: Oulets
    var ViewModel: DetailsViewModel
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var actorsCV: UICollectionView!
    @IBOutlet weak var similarCV: UICollectionView!
    @IBOutlet weak var recomendationsCV: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!
    

    init(ViewModel: DetailsViewModel) {
        self.ViewModel = ViewModel
        super.init(nibName: "DetailsView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
        ViewModel.bindMovie { [weak self] in
            DispatchQueue.main.async {
                self?.actorsCV.reloadData()
                self?.similarCV.reloadData()
                self?.recomendationsCV.reloadData()
            }
        }

    }

    /// Registro de los nibs para el uso de todos los CollectionViews
    func registerNibs() {
        let nib = UINib(nibName: "DetailsCollectionViewCell", bundle: nil)
        actorsCV.register(nib, forCellWithReuseIdentifier: "cell")
        similarCV.register(nib, forCellWithReuseIdentifier: "cell")
        recomendationsCV.register(nib , forCellWithReuseIdentifier: "cell")
    }
    
    /// Se setea todo lo necesario para cargar la vista
    func setView(){
        registerNibs()
        getAllInfo()
        titleLabel.text = ViewModel.getTitle()
        imageMovie.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(ViewModel.getPathImage() ?? "")")!)
        overviewText.text = ViewModel.getOverview()
        voteAverage.text = ViewModel.getRating()
    }
    
    func getAllInfo(){
        ViewModel.getCastMovie()
        ViewModel.getSimilarMovies()
        ViewModel.getRecommendationMovies()
    }
    
    //MARK: - Buttons
    
    @IBAction func favoriteButton(_ sender: UIButton) {

    }
    
}


//MARK: - Extensiones
extension DetailsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case actorsCV:
            return ViewModel.getCastMovieMoviesCount() ?? 0
        case similarCV:
            return ViewModel.getSimilarMoviesCount() ?? 0
        case recomendationsCV:
            return ViewModel.getRecommendationMoviesCount() ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DetailsCollectionViewCell else { return UICollectionViewCell() }
        switch collectionView {
        case actorsCV:
            cell.setInfo(ViewModel, indexPath: indexPath, type: .cast)
            return cell
        case similarCV:
            cell.setInfo(ViewModel, indexPath: indexPath, type: .similar)
            return cell
        case recomendationsCV:
            cell.setInfo(ViewModel, indexPath: indexPath, type: .Recommendation)
            return cell
        default:
            return cell
        }
    }
}
