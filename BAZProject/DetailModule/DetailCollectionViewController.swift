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
extension DetailCollectionViewController {

}

// MARK: - CollectionViewDataSource
extension DetailCollectionViewController {
    
    typealias MediaCellRegistration = UICollectionView.CellRegistration<MediaCollectionViewCell, MediaItem>
    
    func cellRegistrationForMediaSection() -> MediaCellRegistration {
        let nib = UINib(nibName: "DetailOverviewCollectionViewCell", bundle: nil)
        return MediaCellRegistration(cellNib: nib){ (cell: MediaCollectionViewCell, indexPath, item: MediaItem) in
            cell.setCell(with: MediaCollectionViewCellModel(from: item))
        }
    }
    
}
