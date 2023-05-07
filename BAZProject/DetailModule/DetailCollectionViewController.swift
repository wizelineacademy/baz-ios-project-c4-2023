//
//  DetailCollectionViewController.swift
//  BAZProject
//
//  Created by gescarcega on 06/05/23.
//

import UIKit

private let reuseIdentifier = "Cell"

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
