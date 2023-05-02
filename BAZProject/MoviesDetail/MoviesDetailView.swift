//
//  MoviesDetailView.swift
//  BAZProject
//
//  Created by nmorenoa on 25/04/23.
//

import UIKit

final class MoviesDetailView: UIViewController{
    
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgDetailMov: UIImageView!
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
    
    
    var presenter: MoviesDetailViewOutputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.consultReviews()
    }
    
}
// MARK: Extension
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
    
}

extension MoviesDetailView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag == 0 ? presenter?.resultReviews.count ?? 0 : presenter?.resultRecomendations.count ?? 0
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
        }
        return UICollectionViewCell()
    }
    
}

extension MoviesDetailView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}

extension MoviesDetailView: UICollectionViewDelegate{
    
}
