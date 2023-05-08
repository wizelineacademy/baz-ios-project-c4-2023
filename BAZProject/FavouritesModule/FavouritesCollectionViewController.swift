//
//  FavouritesCollectionViewController.swift
//  BAZProject
//
//  Created by gescarcega on 08/05/23.
//

import UIKit

class FavouritesCollectionViewController: UICollectionViewController {

    typealias DataSource = UICollectionViewDiffableDataSource<Int, MediaItem>
    
    private var viewModel: FavouritesViewModel
    var dispatchService: DispatchProtocol = DispatchQueue.main
    var dataSource: DataSource?

    init(viewModel: FavouritesViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.title = "Favourites"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favourites"
        bindSnapshot()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadFavourites()
    }
    
    func bindSnapshot() {
        viewModel.bindSnapshot { [weak self] snapshot in
            self?.dispatchService.async {
                self?.dataSource?.apply(snapshot, animatingDifferences: false)
            }
        }
    }

}

// MARK: - CollectionView DataSource
extension FavouritesCollectionViewController {
    
    private func configureDataSource() {
        let mediaCellRegistration = cellRegistrationForMediaSection()
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: mediaCellRegistration, for: indexPath, item: item)
        }
    }
    
}

// MARK: - CollectionView Cell Registration
extension FavouritesCollectionViewController {
    
    typealias MediaCellRegistration = UICollectionView.CellRegistration<MediaCollectionViewCell, MediaItem>
    
    func cellRegistrationForMediaSection() -> MediaCellRegistration {
        let nib = UINib(nibName: "MediaCollectionViewCell", bundle: nil)
        return MediaCellRegistration(cellNib: nib){ (cell , indexPath, item) in
            cell.setCell(with: MediaCollectionViewCellModel(from: item))
        }
    }
    
}

extension FavouritesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 8 - 32
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt: Int) -> CGFloat {
        return 8.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt: Int) -> CGFloat {
        return 8.0
    }
    
}
