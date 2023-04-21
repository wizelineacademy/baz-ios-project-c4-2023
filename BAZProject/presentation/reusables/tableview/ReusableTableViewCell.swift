//
//  ReusableTableViewCell.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 29/03/23.
//

import Foundation
import UIKit

class ReusableTableViewCell<U>: UITableViewCell {

    // MARK: - Variables

    var item: U!

    // MARK: - Override Functions

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Publics Functions

    func setupViews() {}
}
