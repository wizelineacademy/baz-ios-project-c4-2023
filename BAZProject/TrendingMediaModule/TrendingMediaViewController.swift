//
//  TrendingMediaViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingMediaViewController: UICollectionViewController {
    
    var viewModel: TrendingMediaViewModel
    var dataSource: TrendingMediaViewModel.MediaCollectionDataSource?
    var dispatchService: DispatchProtocol = DispatchQueue.main
    
    init(viewModel: TrendingMediaViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.title = "Trending"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(systemName: "chart.line.uptrend.xyaxis"), selectedImage: UIImage(systemName: "chart.line.uptrend.xyaxis"))
        self.bindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setCollectionView()
        loadInitialData()
    }
    
    // MARK: ViewModel Calls
    private func loadInitialData() {
        viewModel.loadData()
    }
    
    private func bindings() {
        viewModel.bindSnapshot { [weak self] snapshot in
            self?.dispatchService.async {
                self?.dataSource?.apply(snapshot, animatingDifferences: false)
            }
        }
        viewModel.bindError { [weak self] error in
            if let error = error {
                self?.dispatchService.async {
                    self?.presentError(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: Visuals
    
    private func setCollectionView() {
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
    }
    
    private func presentError(_ string: String) {
        let alert = UIAlertController(title: "Oops!", message: string, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
}

// MARK: - CollectionView's Diffable DataSource & Layout

extension TrendingMediaViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(0.33), heightDimension: .fractionalHeight(0.95))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)

            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem( layoutSize: titleSize, elementKind: SimpleCollectionViewHeaderView.kind, alignment: .top)
            section.boundarySupplementaryItems = [titleSupplementary]
            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10

        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = TrendingMediaViewModel.MediaCollectionCellRegistration(cellNib: UINib(nibName: "MediaCollectionViewCell", bundle: nil)) { (cell, indexPath, item) in
            cell.setCell(with: MediaCollectionViewCellModel(from: item))
        }
        dataSource = TrendingMediaViewModel.MediaCollectionDataSource(collectionView: collectionView) {
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailView = viewModel.getDetailView(for: dataSource?.itemIdentifier(for: indexPath)) else { return }
        navigationController?.pushViewController(detailView, animated: true)
    }
    
}
