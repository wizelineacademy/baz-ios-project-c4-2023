//
//  HomeCell.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.
//

import UIKit

class HomeCell: UITableViewCell {

    static let cellID = "HomeCell"
    
    private let coverView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .redraw
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "loader")
        return imageView
    }()
    
    private let movieDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.sizeToFit()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func setupViews() {
        
        self.contentView.addSubview(coverView)
        self.contentView.addSubview(movieDescription)
        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 160).isActive = true
        coverView.translatesAutoresizingMaskIntoConstraints = false
        coverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        coverView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        coverView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        coverView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        coverView.layer.cornerRadius = 5.0
        coverView.layer.masksToBounds = true
        
        movieDescription.translatesAutoresizingMaskIntoConstraints = false
        movieDescription.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8.0).isActive = true
        movieDescription.leadingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: 8.0).isActive = true
        movieDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        movieDescription.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8.0).isActive = true
    }
    
    func setupTitle(title: String) {
        movieDescription.text = title
    }
    
    func setupImage(image: UIImage) {
        coverView.image = image
    }

}
