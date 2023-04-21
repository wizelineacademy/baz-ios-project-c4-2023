//
//  ReusableCollectionView.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 29/03/23.
//

import Foundation
import UIKit

class ReusableCollectionViewController<T: ReusableCollectionViewCell<U>, U>: ReusableViewController {

    // MARK: - Variables
    var reusableDataSource = ReusableCollectionViewDataSource<T, U>()
    var reusableDelegateAndFlowLayout = ReusableCollectionViewDelegateAndFlowLayout()

    var message = ""

    var section = 1

    let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - Override Functions

    override func setupView() {
        super.setupView()
        view.addSubview(collectionView)
        collectionView.dataSource = reusableDataSource
        collectionView.delegate = reusableDelegateAndFlowLayout

        let reuseIdentifier = NSStringFromClass(T.self)
        collectionView.register(T.self, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        collectionView.backgroundColor = .white

        configCollectionView()
    }

    // MARK: - Publics Functions

    func configCollectionView() {}
}
