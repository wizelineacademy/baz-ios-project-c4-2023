//
//  MoviesDetailView.swift
//  BAZProject
//
//  Created by nmorenoa on 25/04/23.
//

import UIKit

final class MoviesDetailView: UIViewController{
    
    // MARK: Properties
    @IBOutlet weak var btnLikes         : UIButton!
    @IBOutlet weak var lblDescription   : UILabel!
    @IBOutlet weak var lblTitle         : UILabel!
    @IBOutlet weak var imgDetailMov     : UIImageView!
    @IBOutlet weak var collectionReviews: UICollectionView!{
        didSet {
            collectionReviews.delegate = self
            collectionReviews.dataSource = self
            if let layout = collectionReviews.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
            collectionReviews.register(CollectionReviewsCell.nib,
                                       forCellWithReuseIdentifier: CollectionReviewsCell.identifier)
        }
    }
    @IBOutlet weak var collectionRecomendations: UICollectionView!{
        didSet {
            collectionRecomendations.delegate = self
            collectionRecomendations.dataSource = self
            if let layout = collectionRecomendations.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
            collectionRecomendations.register(CollectionRecomendationsCell.nib,
                                       forCellWithReuseIdentifier: CollectionRecomendationsCell.identifier)
        }
    }
    @IBOutlet weak var collecionSimilars: UICollectionView!{
        didSet {
            collecionSimilars.delegate = self
            collecionSimilars.dataSource = self
            if let layout = collecionSimilars.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
            collecionSimilars.register(CollectionRecomendationsCell.nib,
                                       forCellWithReuseIdentifier: CollectionRecomendationsCell.identifier)
        }
    }
    
    @IBOutlet weak var vComents: UIView!{
        didSet{
            vComents.isHidden = true
        }
    }
    
    @IBOutlet weak var vRecomendations: UIView!{
        didSet{
            vRecomendations.isHidden = true
        }
    }
    
    @IBOutlet weak var vSimilars: UIView!{
        didSet{
            vSimilars.isHidden = true
        }
    }
    
    var presenter: MoviesDetailViewOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getInfoFavoritesMovies()
        presenter?.viewDidLoad()
    }
    
    @IBAction func btnLike(_ sender: Any) {
        presenter?.addMovieToFavorite()
    }
    
    func setBtnLike(bsIsOn:Bool) {
        let nameImage = bsIsOn ? "suit.heart.fill" : "suit.heart"
        btnLikes.setImage(UIImage(systemName: nameImage), for: .normal)
    }
    
}
// MARK: - Extension
extension MoviesDetailView: MoviesDetailViewInputProtocol{
    
    func setInfoMovie(with movieData: MovieData?) {
        lblTitle.text = movieData?.title
        lblDescription.text = movieData?.overview
        if let posterPath = movieData?.poster_path{
            self.imgDetailMov.download(poster_path: posterPath)
        }
    }
    
    func setReviews() {
        vComents.isHidden = false
        collectionReviews.reloadData()
    }
    
    func setRecomendations() {
        vRecomendations.isHidden = false
        collectionRecomendations.reloadData()
    }
    
    func setSimilars(){
        vSimilars.isHidden = false
        collecionSimilars.reloadData()
    }
    
}
//MARK: - DataSource UICollectionViewDataSource
extension MoviesDetailView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag == 0 ? presenter?.resultReviews.count ?? 0 : collectionView.tag == 1 ? presenter?.resultRecomendations.count ?? 0 : presenter?.resultSimilars.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionReviews {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionReviewsCell", for: indexPath) as? CollectionReviewsCell else { return UICollectionViewCell() }
            cell.setCell(with: presenter?.resultReviews[indexPath.row])
            return cell
        }else if collectionView == self.collectionRecomendations {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionRecomendationsCell", for: indexPath) as? CollectionRecomendationsCell else { return UICollectionViewCell() }
            cell.setCell(with: presenter?.resultRecomendations[indexPath.row])
            return cell
        }else if collectionView == self.collecionSimilars {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionRecomendationsCell", for: indexPath) as? CollectionRecomendationsCell else { return UICollectionViewCell() }
            cell.setCell(with: presenter?.resultSimilars[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
}
//MARK: - FlowLayout UICollectionViewDelegateFlowLayout
extension MoviesDetailView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
//MARK: - Collection UICollectionViewDelegate
extension MoviesDetailView: UICollectionViewDelegate{
    
}
