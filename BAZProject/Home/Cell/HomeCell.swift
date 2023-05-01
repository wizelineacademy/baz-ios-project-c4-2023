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
    private let coverView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .redraw
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "poster")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = ConstraintConstants.cornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let movieDescription: GreenLabel = {
        let label = GreenLabel(frame: .zero)
        label.sizeToFit()
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
        self.contentView.backgroundColor = UIColor.AppColors.homeCellBackgroundColor
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
            coverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstraintConstants.small),
            coverView.heightAnchor.constraint(equalToConstant: CellConstants.coverViewHeight),
            coverView.widthAnchor.constraint(equalToConstant: CellConstants.coverViewCenterY),
            coverView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            movieDescription.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: ConstraintConstants.small),
            movieDescription.leadingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: ConstraintConstants.medium),
            movieDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieDescription.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -ConstraintConstants.small)
        ])
    }
    
    func setupTitle(title: String) {
        movieDescription.text = title
    }
    
    func setupImage(image: UIImage) {
        coverView.image = image
    }

}
