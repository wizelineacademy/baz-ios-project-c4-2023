//
//  TrendingMoviesViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingMoviesViewController: UICollectionViewController {
    
    private var viewModel: TrendingMoviesViewModel
    
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
                self?.collectionView.reloadData()
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
        collectionView.register(UINib(nibName: "MediaCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MediaCollectionViewCell")
    }
    
    private func presentError() {
        guard let message = viewModel.getError() else { return }
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
}

// MARK: - CollectionView's DataSource

extension TrendingMoviesViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getRowCount(for: section)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getSectionCount()
    }
    
}

// MARK: - CollectionView's Delegate

extension TrendingMoviesViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as? MediaCollectionViewCell else { return UICollectionViewCell() }
        let cellModel = viewModel.getCellConfiguration(indexPath: indexPath)
        cell.setCell(with: cellModel)
        return cell
    }
    
}

// MARK: - CollectionView's Flow Layout Delegate

extension TrendingMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
}
