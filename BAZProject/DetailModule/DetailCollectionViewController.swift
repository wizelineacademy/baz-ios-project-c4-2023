//
//  DetailCollectionViewController.swift
//  BAZProject
//
//  Created by gescarcega on 06/05/23.
//

import UIKit

class DetailCollectionViewController: UICollectionViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<DetailSection, AnyHashable>
    
    private var viewModel: DetailViewModel
    var dispatchService: DispatchProtocol = DispatchQueue.main
    var dataSource: DataSource?

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationController?.navigationItem.title = viewModel.getTitle()
        configureDataSource()
    }
    
}

// MARK: - CollectionViewFlowLayout
extension DetailCollectionViewController {}

// MARK: - CollectionView DataSource
extension DetailCollectionViewController {
    
    private func configureDataSource() {
        let overviewCellRegistration = cellRegistrationForOverviewSection()
        let castCellRegistration = cellRegistrationForCastSection()
        let reviewCellRegistration = cellRegistrationForReviewSection()
        let mediaCellRegistration = cellRegistrationForMediaSection()
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            if let overviewItem = item as? DetailOverview {
                return collectionView.dequeueConfiguredReusableCell(using: overviewCellRegistration, for: indexPath, item: overviewItem)
            } else if let castItem = item as? DetailCastMember {
                return collectionView.dequeueConfiguredReusableCell(using: castCellRegistration, for: indexPath, item: castItem)
            } else if let reviewItem = item as? DetailReview {
                return collectionView.dequeueConfiguredReusableCell(using: reviewCellRegistration, for: indexPath, item: reviewItem)
            } else if let mediaItem = item as? MediaItem {
                return collectionView.dequeueConfiguredReusableCell(using: mediaCellRegistration, for: indexPath, item: mediaItem)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: mediaCellRegistration, for: indexPath, item: MediaItem())
            }
        }

    }
    
}

// MARK: - CollectionView Cell Registration
extension DetailCollectionViewController {
    
    typealias OverviewCellRegistration = UICollectionView.CellRegistration<DetailOverviewCollectionViewCell, DetailOverview>
    typealias CastCellRegistration = UICollectionView.CellRegistration<MediaCollectionViewCell, DetailCastMember>
    typealias ReviewCellRegistration = UICollectionView.CellRegistration<DetailReviewCollectionViewCell, DetailReview>
    typealias MediaCellRegistration = UICollectionView.CellRegistration<MediaCollectionViewCell, MediaItem>
    
    func cellRegistrationForMediaSection() -> MediaCellRegistration {
        let nib = UINib(nibName: "MediaCollectionViewCell", bundle: nil)
        return MediaCellRegistration(cellNib: nib){ (cell , indexPath, item) in
            cell.setCell(with: MediaCollectionViewCellModel(from: item))
        }
    }
    
    func cellRegistrationForOverviewSection() -> OverviewCellRegistration {
        let nib = UINib(nibName: "DetailOverviewCollectionViewCell", bundle: nil)
        return OverviewCellRegistration(cellNib: nib){ (cell, indexPath, item) in
            cell.setCell(with: item)
        }
    }
    
    func cellRegistrationForCastSection() -> CastCellRegistration {
        let nib = UINib(nibName: "MediaCollectionViewCell", bundle: nil)
        return CastCellRegistration(cellNib: nib){ (cell, indexPath, item) in
            var model = MediaCollectionViewCellModel(from: item.actor)
            model.subtitle = item.character
            cell.setCell(with: model)
        }
    }
    
    func cellRegistrationForReviewSection() -> ReviewCellRegistration {
        let nib = UINib(nibName: "DetailReviewCollectionViewCell", bundle: nil)
        return ReviewCellRegistration(cellNib: nib){ (cell, indexPath, item) in
            cell.setCell(with: item)
        }
    }
    
}
