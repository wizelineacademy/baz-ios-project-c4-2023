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
    private var saveButtonImage: UIImage!
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
        navigationController?.navigationBar.prefersLargeTitles = false
        title = viewModel.getTitle()
        collectionView.collectionViewLayout = createLayout()
        setSaveButton()
        bindSnapshot()
        configureDataSource()
        viewModel.getDetails()
    }
    
    func bindSnapshot() {
        viewModel.bindSnapshot { [weak self] snapshot in
            self?.dispatchService.async {
                self?.dataSource?.apply(snapshot, animatingDifferences: false)
            }
        }
    }
    
    func bindFavourites() {
        viewModel.bindFavourite { [weak self] favourite in
            self?.saveButtonImage.withTintColor(favourite ? .systemBlue : .systemGray, renderingMode: .alwaysTemplate)
        }
    }
    
    func setSaveButton() {
        saveButtonImage = UIImage(systemName: "star.fill")
        let saveButtonItem = UIBarButtonItem(image: saveButtonImage, style: .plain, target: self, action: #selector(saveOrRemoveItemToFavourites))
        navigationItem.rightBarButtonItem = saveButtonItem
    }
    
    @objc func saveOrRemoveItemToFavourites() {
        viewModel.saveOrDeleteItem()
    }
    
}

// MARK: - CollectionViewFlowLayout
extension DetailCollectionViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let detailSection = self?.viewModel.getDetailSections()?[sectionIndex] else { return nil }
            var group: NSCollectionLayoutGroup!
            var section: NSCollectionLayoutSection!
            var titleSupplementary: NSCollectionLayoutBoundarySupplementaryItem?
            switch detailSection {
            case .overview:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .estimated(187))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(187))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                section = NSCollectionLayoutSection(group: group)
            case .reviews:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.9))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                section = NSCollectionLayoutSection(group: group)
                let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
                titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem( layoutSize: titleSize, elementKind: SimpleCollectionViewHeaderView.kind, alignment: .top)
            default:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(0.33), heightDimension: .fractionalHeight(0.95))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
                titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem( layoutSize: titleSize, elementKind: SimpleCollectionViewHeaderView.kind, alignment: .top)
            }
            section.orthogonalScrollingBehavior = .continuous
            if let titleSupplementary = titleSupplementary {
                section.boundarySupplementaryItems = [titleSupplementary]
            }
            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10

        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
}

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
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<SimpleCollectionViewHeaderView>(elementKind: SimpleCollectionViewHeaderView.kind) { [weak self] (supplementaryView, elementKind, indexPath) in
            guard let detailSection = self?.viewModel.getDetailSections()?[indexPath.section],
                  let title = detailSection.title else { return }
            supplementaryView.title.text = title
        }
        dataSource?.supplementaryViewProvider = { [weak self] (view, kind, index) in
            return self?.collectionView.dequeueConfiguredReusableSupplementary( using: supplementaryRegistration, for: index)
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
