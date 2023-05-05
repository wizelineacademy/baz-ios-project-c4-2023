//
//  MovieListCollectionView.swift
//  BAZProject
//
//  Created by Carlos Garcia on 19/04/23.
//

import UIKit

protocol MovieListCollectionViewDelegate {
    func movieListCollectionView(_ collectionView: MovieListCollectionView, didSelectItemAt indexPath: IndexPath)
}

class MovieListCollectionView: UIView {
    
    @IBOutlet private weak var lblSectionTitle: UILabel!
    @IBOutlet private weak var collVwMovieItems: UICollectionView! {
        didSet {
            collVwMovieItems.delegate = self
            collVwMovieItems.dataSource = self
            collVwMovieItems.register(UINib(nibName: MovieListCollectionCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: MovieListCollectionCell.reusableIdentifier)
        }
    }
    
    private var arrMovies: [MovieInfo] = []
    
    public var section: Int = 0
    public var delegate: MovieListCollectionViewDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        MovieListCollectionView.initXIB(owner: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        MovieListCollectionView.initXIB(owner: self)
    }
    
    public func setTitle(_ strTitle: String) {
        self.lblSectionTitle.text = strTitle
    }
    
    public func setMovies(_ arrMovies: [MovieInfo]) {
        self.arrMovies = arrMovies
        self.reloadScroll()
    }
    
    private func reloadScroll() {
        self.collVwMovieItems.reloadData()
        self.collVwMovieItems.scrollRectToVisible(collVwMovieItems.frame, animated: true)
    }
}

extension MovieListCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.movieListCollectionView(self, didSelectItemAt: IndexPath(row: indexPath.row, section: self.section))
    }
}

extension MovieListCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionCell.reusableIdentifier, for: indexPath) as? MovieListCollectionCell {
            let movieInfo = arrMovies[indexPath.row]
            cell.updateView(with: movieInfo)
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
}
