//
//  DetailCollectionViewController.swift
//  BAZProject
//
//  Created by gescarcega on 06/05/23.
//

import UIKit

class DetailCollectionViewController: UICollectionViewController {
    
    private var viewModel: DetailViewModel
    var dispatchService: DispatchProtocol = DispatchQueue.main

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationController?.navigationItem.title = viewModel.getTitle()
    }
    
}

// MARK: - CollectionViewFlowLayout
extension DetailCollectionViewController {}

// MARK: - CollectionView DataSource
extension DetailCollectionViewController {
    
    
    
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
