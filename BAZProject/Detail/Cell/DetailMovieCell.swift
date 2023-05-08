//
//  DetailMovieCell.swift
//  BAZProject
//
//  Created by jehernandezg on 04/05/23.
//

import UIKit

class DetailMovieCell: UICollectionViewCell {
    lazy var coverView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = ConstraintConstants.cornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private lazy var producersTitle: GreenLabel = {
        let label = GreenLabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return label
    }()
    
    var model: ListMovieProtocol? {
        didSet {
            producersTitle.text = model?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.contentView.layer.cornerRadius = ConstraintConstants.cornerRadius
        self.contentView.backgroundColor = UIColor.AppColors.backgroudColor
        self.contentView.addSubview(coverView)
        self.contentView.addSubview(producersTitle)
        
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ConstraintConstants.semiSmall),
            coverView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: ConstraintConstants.semiSmall),
            coverView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -ConstraintConstants.semiSmall),
            coverView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -ConstraintConstants.semiSmall),
   
            producersTitle.heightAnchor.constraint(equalToConstant: contentView.bounds.height * 0.4),
            producersTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            producersTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            producersTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
