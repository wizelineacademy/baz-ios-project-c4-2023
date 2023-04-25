//
//  HomeCell.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.
//

import UIKit

//MARK: - Class
class HomeCell: UITableViewCell {
    //MARK: - Properties
    static let cellID = "HomeCell"
    
    private let coverView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .redraw
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "loader")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let movieDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.sizeToFit()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Init methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        self.selectionStyle = .none
        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 140).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Functions
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupViews() {
        self.contentView.addSubview(coverView)
        self.contentView.addSubview(movieDescription)

        NSLayoutConstraint.activate([
            coverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverView.heightAnchor.constraint(equalToConstant: 120),
            coverView.widthAnchor.constraint(equalToConstant: 90),
            coverView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            movieDescription.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            movieDescription.leadingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: 12.0),
            movieDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieDescription.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8.0)
        ])
    }
    
    func setupTitle(title: String) {
        movieDescription.text = title
    }
    
    func setupImage(image: UIImage) {
        coverView.image = image
    }

}
