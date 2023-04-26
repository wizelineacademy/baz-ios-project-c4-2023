//
//  HomeCell.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.
//

import UIKit

struct CellConstants {
    static let small = 8.0
    static let regular = 12.0
    static let cornerRadius = 5.0
    static let viewHeightAnchor = 140.0
    static let coverViewHeight = 120.0
    static let coverViewCenterY = 90.0
    static let cellID = "HomeCell"
}

//MARK: - Class
class HomeCell: UITableViewCell {
    //MARK: - Properties
    private let coverView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .redraw
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "loader")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = CellConstants.cornerRadius
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
        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: CellConstants.viewHeightAnchor).isActive = true
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
            coverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CellConstants.small),
            coverView.heightAnchor.constraint(equalToConstant: CellConstants.coverViewHeight),
            coverView.widthAnchor.constraint(equalToConstant: CellConstants.coverViewCenterY),
            coverView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            movieDescription.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: CellConstants.small),
            movieDescription.leadingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: CellConstants.regular),
            movieDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieDescription.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -CellConstants.small)
        ])
    }
    
    func setupTitle(title: String) {
        movieDescription.text = title
    }
    
    func setupImage(image: UIImage) {
        coverView.image = image
    }

}
