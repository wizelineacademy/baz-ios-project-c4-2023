//
//  SimpleCollectionViewHeaderView.swift
//  BAZProject
//
//  Created by gescarcega on 27/04/23.
//

import UIKit

class SimpleCollectionViewHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "ReusableTitle"
    static let kind = "KindTitle"
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        title.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        title.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        title.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

