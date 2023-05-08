//
//  DetailMovieView.swift
//  BAZProject
//
//  Created by Ben Frank V. on 03/05/23.
//  
//

import Foundation
import UIKit

class DetailMovieView: UIViewController {

    @IBOutlet weak var imvBackPoster: UIImageView!
    @IBOutlet weak var lblTitleView: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblCast: UILabel!
    @IBOutlet weak var lycImage: NSLayoutConstraint!
    @IBOutlet weak var clvRevSimRec: UICollectionView!
    
    @IBOutlet weak var lycCollectionViewHeight: NSLayoutConstraint!
    // MARK: Properties
    var presenter: DetailMoviePresenterProtocol?
    private var data = [ListSection]()

    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.willFetchDetailsMovie()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        clvRevSimRec.collectionViewLayout = createLayout()
    }
}

extension DetailMovieView: DetailMovieViewProtocol {
    func registrerCell() {
        clvRevSimRec.register(UINib(nibName: GeneralCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: GeneralCollectionViewCell.identifier)
        clvRevSimRec.register(UINib(nibName: ReviewsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ReviewsCollectionViewCell.identifier)
        clvRevSimRec.register(TitleSectionCollectionReusableView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSectionCollectionReusableView.identifier)
    }
    
    
    func updateData(data: [ListSection]) {
        self.data = data
        DispatchQueue.main.async {
            self.clvRevSimRec.reloadData()
        }
    }
    
    func getImage(_ linkPosterBack: String) {
        GetImage.getImage(pathPoster: linkPosterBack) { image in
            DispatchQueue.main.async { [weak self] in
                if let poster = image {
                    self?.imvBackPoster.image = poster
                }else{
                    let newConstraint = self?.lycImage.constraintWithMultiplier(0.0)
                    self?.view.removeConstraint((self?.lycImage)!)
                    self?.view.addConstraint(newConstraint!)
                    self?.view.layoutIfNeeded()
                    self?.lycImage = newConstraint
                }
                
            }
            
        }
    }
    
    func titleMovie(_ title: String) {
        DispatchQueue.main.async {
            self.lblTitleView.text = title
        }
    }
    
    func overview(_ overview: String) {
        DispatchQueue.main.async {
            self.lblOverview.text = overview
        }
        
    }
    
    func cast(_ cast: String) {
        DispatchQueue.main.async {
            self.lblCast.text = cast
        }
    }
    
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}

extension DetailMovieView: UICollectionViewDelegate, UICollectionViewDataSource {
    //- MARK: Layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnviorement in
            guard let self = self else {return nil}
            let section = self.data[sectionIndex]
            let width: CGFloat = UIScreen.main.bounds.width * 0.82
            let height: CGFloat = width * 0.65
            self.lycCollectionViewHeight.constant = (height + 50) * 3
            switch section {
            case .reviews:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(width), heightDimension: .absolute(height)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            case .similarMovies:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(width), heightDimension: .absolute(height)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            case .recommendsMovies:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(width), heightDimension: .absolute(height)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            
                
            }
        }
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem{
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    //- MARK: Header Manager
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleSectionCollectionReusableView.identifier, for: indexPath)
            guard let titleHeader = header as? TitleSectionCollectionReusableView else { return header }
            let title = data[indexPath.section].title
            titleHeader.setup(title: title)
            return titleHeader
        default:
            return UICollectionReusableView()
        }
         
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 48)
    }
    
    //- MARK: Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch data[indexPath.section] {
        case .similarMovies(let items):
            let movie = items[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralCollectionViewCell.identifier, for: indexPath)
            guard let cellGeneral = cell as? GeneralCollectionViewCell else { return cell }
            cellGeneral.setup(movie)
            return cellGeneral
        case .recommendsMovies(let items):
            let movie = items[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralCollectionViewCell.identifier, for: indexPath)
            guard let cellGeneral = cell as? GeneralCollectionViewCell else { return cell }
            cellGeneral.setup(movie)
            return cellGeneral
        case .reviews(let items):
            let review = items[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsCollectionViewCell.identifier, for: indexPath)
            guard let cellReview = cell as? ReviewsCollectionViewCell else { return cell }
            cellReview.septup(review)
            return cellReview
        }
    }
    
    
}

