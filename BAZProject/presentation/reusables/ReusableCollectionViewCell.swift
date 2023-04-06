//
//  ReusableCollectionViewCell.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 29/03/23.
//

import Foundation
import UIKit

class ReusableCollectionViewCell<U>: UICollectionViewCell {

    // MARK: - Variables

    var item:U!

    // MARK: - Override Functions

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Publics Functions

    func setupViews() {}
}
