//
//  DetailMovieCell.swift
//  BAZProject
//
//  Created by jehernandezg on 04/05/23.
//

import UIKit

class DetailMovieCell: UICollectionViewCell {
    private lazy var coverView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "loader")
        return imageView
    }()
    var producersTitle: GreenLabel = {
        let label = GreenLabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()
    
//    var model: Production_companies? {
//        didSet {
//            coverView.downloadImage(path: model?.logo_path ?? "")
//            producersTitle.text = model?.name
//        }
//    }
    
    //var presenter: HomeViewOutput?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.contentView.layer.cornerRadius = 10
        //self.contentView.backgroundColor = UIColor.AppColors.navigationColor
        self.contentView.addSubview(coverView)
        self.contentView.addSubview(producersTitle)
        
        coverView.translatesAutoresizingMaskIntoConstraints = false
        coverView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        coverView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 4).isActive = true
        coverView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -4).isActive = true
        coverView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        coverView.layer.cornerRadius = 8
        
        producersTitle.translatesAutoresizingMaskIntoConstraints = false
        producersTitle.topAnchor.constraint(equalTo: coverView.bottomAnchor, constant: 4).isActive = true
        producersTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        producersTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
    }
}
