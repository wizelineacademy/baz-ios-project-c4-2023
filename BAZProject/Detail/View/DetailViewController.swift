//
//  DetailViewController.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 02/05/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Variables
    var model = Movie()
    var imageCache2: NSCache = NSCache< NSString, UIImage>()
    var networkManager = NetworkManager()
    var actors: [Actor] = [] {
        didSet {
            reloadDetailView()
        }
    }
    var similars: [Movie] = [] {
        didSet {
            reloadDetailView()
        }
    }
    var recomendations: [Movie] = [] {
        didSet {
            reloadDetailView()
        }
    }
    var reviews: [Viewable] = []
    
    var isActor: Bool = true
    
    func getReviewsFromArray() -> String{
        var text: String = ""
        for review in reviews {
            text.append("\(review.getTitle()): \n")
            text.append("\(review.getOverview()) \n")
            text.append("\n")
        }
        print(text)
        return text
    }
    
    // MARK: UIElements
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ReleaseDateLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var OverviewLabel: UILabel!
    @IBOutlet weak var ActorsLabel: UILabel!
    @IBOutlet weak var ActorsCollection: UICollectionView!
    @IBOutlet weak var SimilarLabel: UILabel!
    @IBOutlet weak var SimilarCollection: UICollectionView!
    @IBOutlet weak var RecommendationLabel: UILabel!
    @IBOutlet weak var RecommendationCollection: UICollectionView!
    @IBOutlet weak var ReviewLabel: UILabel!
    @IBOutlet weak var ReviewsTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
    }
    
    func initialConfiguration(){
        setDetailView()
        registerCollectionViewCell(cellName: "MovieAppCollectionViewCell", identifier: "HomeViewCellId")
        assignDataSourceAndDelegates()
    }
    
    func setDetailView(){
        ReleaseDateLabel.text = model.getAdditionalInfo()
        TitleLabel.text = model.title
        OverviewLabel.text = model.overview
        getMovieDetails(movieId: model.getId()!)
        ItemImage.image = getImage(using: model.getImagePath() ?? "", isTopView: true)
        ReviewsTextView.text = getReviewsFromArray()
        
        if isActor{
            ActorsLabel.text = "Appears in:"
            
            ReleaseDateLabel.isHidden = true
            OverviewLabel.isHidden = true
            SimilarLabel.isHidden = true
            SimilarCollection.isHidden = true
            RecommendationLabel.isHidden = true
            RecommendationCollection.isHidden = true
            ReviewLabel.isHidden = true
            ReviewsTextView.isHidden = true
        }
    }
    
    func registerCollectionViewCell(cellName: String, identifier: String){
        ActorsCollection.register(UINib(nibName: cellName, bundle: .main), forCellWithReuseIdentifier: identifier)
        SimilarCollection.register(UINib(nibName: cellName, bundle: .main), forCellWithReuseIdentifier: identifier)
        RecommendationCollection.register(UINib(nibName: cellName, bundle: .main), forCellWithReuseIdentifier: identifier)
    }
    
    func assignDataSourceAndDelegates(){
        ActorsCollection.dataSource = self
        ActorsCollection.delegate = self
        SimilarCollection.dataSource = self
        SimilarCollection.delegate = self
        RecommendationCollection.dataSource = self
        RecommendationCollection.delegate = self
    }
    
    func getImage(using: String, isTopView: Bool) -> UIImage {
        print(using)
        guard var defaultImage = UIImage(named: "poster") else {
            return UIImage()
        }
        var basePath = "https://image.tmdb.org/t/p/w500"
        basePath.append(using)
        print(basePath)
        guard let newUrl = URL(string: basePath) else {
            return defaultImage
        }
        
        if let cacheImage = loadFromCache(imageAt: newUrl) {
            print("Image already in cache")
            return cacheImage
        } else {
            print("Image not in cache")
            loadImage(newUrl, isTopView: isTopView){ image in
                defaultImage = image ?? defaultImage
            }
            //Reload the view to show the images
//            reloadDetailView()
            return defaultImage
        }
    }
    
    func loadFromCache(imageAt url: URL) -> UIImage? {
        let imageKey = url.absoluteString as NSString
        return imageCache2.object(forKey: imageKey)
    }
    
    func loadImage(_ url: URL, isTopView: Bool, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            self.imageCache2.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                completion(image)
                if isTopView{
                    self.updateImage(with: image)
                }
                //Se cargan las imágenes de los carruceles
            }
        }
    }
    
    func updateImage(with: UIImage) {
        DispatchQueue.main.async {
            self.ItemImage.image = with
        }
    }
    
    func getMovieDetails(movieId: Int) {
        print(movieId)
        networkManager.getMovies(endpoint: .cast(movieId: movieId)) { (result: CastResponse?, error) in
            if let error = error {
                print("TENEMOS ERROR EN LA CONSULTA DE CAST")
                return
            } else if let movieCast = result?.actors {
                print("TENEMOS RESPUESTA EN EL CAST(REPARTO):")
//                print(movieCast)
                self.actors = movieCast
            }
        }
        
        networkManager.getMovies(endpoint: .similar(movieId: movieId)){ (result: MovieApiResponse?, error) in
            if let error = error {
                print("TENEMOS ERROR EN LA CONSULTA DE SIMILARES")
                return
            } else if let similarMovies = result?.movies {
                print("TENEMOS RESPUESTA EN SIMILARES:")
//                print(similarMovies)
                self.similars = similarMovies
            }
        }
        
        networkManager.getMovies(endpoint: .recommendations(movieId: movieId)){ (result: MovieApiResponse?, error) in
            if let error = error {
                print("TENEMOS ERROR EN LA CONSULTA DE RECOMMENDATIONS")
                return
            } else if let recommendedMovies = result?.movies {
                print("TENEMOS RESPUESTA EN RECOMMENDED:")
//                print(recommendedMovies)
                self.recomendations = recommendedMovies
            }
        }
        
        networkManager.getMovies(endpoint: .reviews(movieId: movieId)){ (result: ReviewsResponse?, error) in
            if let error = error {
                print("TENEMOS ERROR EN LA CONSULTA DE REVIEWS")
                return
            } else if let movieReviews = result?.reviews {
                print("TENEMOS RESPUESTA EN REVIEWS:")
//                print(movieReviews)
                self.reviews = movieReviews
                print(movieReviews)
                DispatchQueue.main.async {
                    self.ReviewsTextView.text = self.getReviewsFromArray()
                }
            }
        }
    }
    
    func reloadDetailView(){
        DispatchQueue.main.async { [weak self] in
            self?.ActorsCollection.reloadData()
            self?.SimilarCollection.reloadData()
            self?.RecommendationCollection.reloadData()
        }
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ActorsCollection {
            return actors.count
        } else if collectionView == SimilarCollection {
            return similars.count
        } else if collectionView == RecommendationCollection {
            return recomendations.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCellId", for: indexPath) as? MovieAppCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if collectionView == ActorsCollection {
            cell.cellLabel.text = actors[indexPath.row].title
            cell.cellImageView.image = self.getImage(using: actors[indexPath.row].getImagePath()!, isTopView: false)
        } else if collectionView == SimilarCollection {
            cell.cellLabel.text = similars[indexPath.row].title
            ImageManager.shared.getImage(urlImage: similars[indexPath.row].getImagePath() ?? "") { image in
                cell.cellImageView.image = image
            }
//            cell.cellImageView.image = self.getImage(using: similars[indexPath.row].getImagePath()!, isTopView: false)
        } else if collectionView == RecommendationCollection {
            cell.cellLabel.text = recomendations[indexPath.row].title
            cell.cellImageView.image = self.getImage(using: recomendations[indexPath.row].getImagePath()!, isTopView: false)
        }
        
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:  IndexPath) {
        
        var model:Viewable
        
        switch collectionView {
        case ActorsCollection:
            let selectedModel: Viewable = actors[indexPath.row]
            print("Actor selected with name: \(selectedModel.title) and id: \(selectedModel.id)")
        case SimilarCollection:
            let selectedModel: Viewable = similars[indexPath.row]
            print("Similar selected with name: \(selectedModel.title) and id: \(selectedModel.id)")
        case RecommendationCollection:
            let selectedModel: Viewable = recomendations[indexPath.row]
            print("Recommendation selected with name: \(selectedModel.title) and id: \(selectedModel.id)")
        default:
            print("You selected something else.")
        }
    }
}
