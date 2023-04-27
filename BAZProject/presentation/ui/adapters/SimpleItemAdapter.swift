//
//  SimpleItemAdapter.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 27/04/23.
//

import Foundation
import UIKit

class SimpleItemAdapter: ReusableTableViewCell<String> {
    
    // MARK: - Input/View and Constraints
    private lazy var lblKeyword: UILabel = {
        let lbl = UILabel()
        let sizeFont: CGFloat = .dim12
        lbl.font = UIFont(name: "ArialNarrow", size: sizeFont)
        lbl.font = UIFont.systemFont(ofSize: sizeFont)
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private func lblKeywordConstraints() {
        addSubview(lblKeyword)
        lblKeyword.topAnchor.constraint(equalTo: topAnchor, constant: .dim4).isActive = true
        lblKeyword.trailingAnchor.constraint(equalTo:  trailingAnchor, constant: -.dim4).isActive = true
        lblKeyword.bottomAnchor.constraint(equalTo:  bottomAnchor, constant: -.dim4).isActive = true
        lblKeyword.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: .dim4).isActive = true
    }
    
    // MARK: - Override Functions/Variables

    override var item: String!{
        didSet{
            lblKeyword.text = item
        }
    }

    override func setupViews() {
        super.setupViews()
        lblKeywordConstraints()
    }
}
