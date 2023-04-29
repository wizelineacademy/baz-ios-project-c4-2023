//
//  TrendingMoviesViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingMoviesViewController: UICollectionViewController {
    
    private var viewModel: TrendingMoviesViewModel
    private var dataSource: TrendingMoviesViewModel.MediaCollectionDataSource?
    
    init(viewModel: TrendingMoviesViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.title = "Trending"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
        self.bindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        loadInitialData()
    }
    
    // MARK: ViewModel Calls
    private func loadInitialData() {
        viewModel.getMovies()
    }
    
    private func bindings() {
        viewModel.bindMovies { [weak self] in
            DispatchQueue.main.async {
                guard let snapShot = self?.viewModel.getDataSnapshot() else { return }
                self?.dataSource?.apply(snapShot, animatingDifferences: false)
            }
        }
        viewModel.bindError { [weak self] in
            DispatchQueue.main.async {
                self?.presentError()
            }
        }
    }
    
    // MARK: Visuals
    
    private func setCollectionView() {
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
    }
    
    private func presentError() {
        guard let message = viewModel.getError() else { return }
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
}

// MARK: - CollectionView's Layout

extension TrendingMoviesViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.8))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            // if we have the space, adapt and go 2-up + peeking 3rd item
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)

            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem( layoutSize: titleSize, elementKind: SimpleCollectionViewHeaderView.kind, alignment: .top)
            section.boundarySupplementaryItems = [titleSupplementary]
            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20

        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = TrendingMoviesViewModel.MediaCollectionCellRegistration(cellNib: UINib(nibName: "MediaCollectionViewCell", bundle: nil)) { [weak self] (cell, indexPath, item) in
            guard let cellModel = self?.viewModel.getCellConfiguration(item: item) else { return }
            cell.setCell(with: cellModel)
        }
        dataSource = TrendingMoviesViewModel.MediaCollectionDataSource(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<SimpleCollectionViewHeaderView>(elementKind: SimpleCollectionViewHeaderView.kind) { [weak self] (supplementaryView, elementKind, indexPath) in
            supplementaryView.title.text = self?.viewModel.getGroupTitle(for: indexPath.section)
        }
        dataSource?.supplementaryViewProvider = { [weak self] (view, kind, index) in
            return self?.collectionView.dequeueConfiguredReusableSupplementary( using: supplementaryRegistration, for: index)
        }
    }
    
}
