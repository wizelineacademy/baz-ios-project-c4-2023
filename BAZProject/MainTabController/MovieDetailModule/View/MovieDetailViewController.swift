//
//  MovieDetailViewController.swift
//  BAZProject
//
//  Created by 989438 on 29/03/23.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    @IBOutlet weak var movieCollection: UICollectionView!
    var presenter: MovieDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let movie = presenter?.movieModel[0].items[0] as? Movie
        title = movie?.title
        presenter?.getMovieBanner()
        presenter?.searchForActors(in: movie?.id ?? 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.presenter?.searchForReviews(for: movie?.id ?? 0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.presenter?.searchForSimilarMovies(of: movie?.id ?? 0)
            self.presenter?.searchForRecommendedMovies(of: movie?.id ?? 0)
        }
        movieCollection.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self, let section = self.presenter?.movieModel[sectionIndex] else { return nil }
        
            switch section {
            case .summary:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1))
                let group = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .fractionalHeight(0.65), items: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .starring:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1))
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .absolute(133), height: .absolute(149), items: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [self.suplementaryHeaderItem()]
                return section
            case .similar:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), bottomSpacing: 15, leadingSpacing: 10, trailingSpacing: 10)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(0.6), height: .fractionalHeight(0.6), items: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [self.suplementaryHeaderItem()]
                return section
            case .recomended:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), bottomSpacing: 15, leadingSpacing: 10, trailingSpacing: 10)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(0.6), height: .fractionalHeight(0.6), items: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [self.suplementaryHeaderItem()]
                return section
            case .reviews:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), bottomSpacing: 15, leadingSpacing: 10, trailingSpacing: 10)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(0.9), height: .fractionalHeight(0.4), items: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.boundarySupplementaryItems = [self.suplementaryHeaderItem()]
                return section
            }
        }
    }
    
    private func suplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}

extension MovieDetailViewController: MovieDetailViewControllerProtocol {
    func reloadMovieDetailInfo() {
        movieCollection.reloadData()
    }
    
    func reload(with error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension MovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sections = presenter?.movieModel[indexPath.section] else { return }
        switch sections {
        case .summary:
            return
        case .starring:
            return
        case .similar(let items):
            presenter?.didSelectRowAt(indexPath, items)
        case .recomended(let items):
            presenter?.didSelectRowAt(indexPath, items)
        case .reviews(_):
            return
        }
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let count: Int = presenter?.movieModel.count else {
            return .zero
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count: Int = presenter?.movieModel[section].count else {
            return .zero
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sections = presenter?.movieModel[indexPath.section] else { return UICollectionViewCell() }
        switch sections {
        case .summary(let items):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCollectionCell.reusableIdentifier, for: indexPath) as? SummaryCollectionCell else { return UICollectionViewCell() }
            cell.setup(movieDetailModel: items[indexPath.row])
            return cell
        case .starring(let items):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StarringCollectionCell.reusableIdentifier, for: indexPath) as? StarringCollectionCell else { return UICollectionViewCell() }
            cell.setup(movieDetailModel: items[indexPath.row])
            return cell
        case .similar(let items):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.reusableIdentifier, for: indexPath) as? MovieCollectionCell else { return UICollectionViewCell() }
            cell.setup(movieDetailModel: items[indexPath.row])
            return cell
        case .recomended(let items):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.reusableIdentifier, for: indexPath) as? MovieCollectionCell else { return UICollectionViewCell() }
            cell.setup(movieDetailModel: items[indexPath.row])
            return cell
        case .reviews(let items):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionCell.reusableIdentifier, for: indexPath) as? ReviewCollectionCell else { return UICollectionViewCell() }
            cell.setup(review: items[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewHeaderReusableView.reusableIdentifier, for: indexPath) as! CollectionViewHeaderReusableView
            header.setup(presenter?.movieModel[indexPath.section].title ?? "")
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
