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
    
    private let favoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    var presenter: HomeViewOutputProtocol?
    var searchPresenter: SearchViewOutputProtocol?
    var index: Int? = 0
    var isHome: Bool = false
    var model: MovieResult? {
        didSet {
            movieDescription.text = model?.title
            if isHome {
                self.presenter?.getMovieImage(index: index ?? 0, completion: {[weak self] imageData in
                    self?.coverView.image = imageData
                })
            } else {
                self.searchPresenter?.getMovieImage(index: index ?? 0, completion: {[weak self] imageData in
                    self?.coverView.image = imageData
                })
            }
            let outLine: UIImage = UIImage(systemName: "star") ?? UIImage()
            let filled: UIImage = UIImage(systemName: "star.fill") ?? UIImage()
            favoriteButton.setImage(model?.isFavorite ?? false ? filled : outLine, for: .normal)
            //favoriteButton.isHidden = comesFromFavorite
        }
    }
    
    //MARK: - Functions
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coverView.image = UIImage(named: "poster")
    }
    
    func setupViews() {
        self.contentView.addSubview(coverView)
        self.contentView.addSubview(movieDescription)
        self.contentView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            coverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstraintConstants.small),
            coverView.heightAnchor.constraint(equalToConstant: CellConstants.coverViewHeight),
            coverView.widthAnchor.constraint(equalToConstant: CellConstants.coverViewCenterY),
            coverView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favoriteButton.rightAnchor.constraint(equalTo: coverView.rightAnchor, constant: 8),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            movieDescription.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: ConstraintConstants.small),
            movieDescription.leadingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: ConstraintConstants.medium),
            movieDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieDescription.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -ConstraintConstants.small)
        ])
    }
    
    @objc func didTapFavorite() {
        if isHome {
            if model?.isFavorite ?? false {
                presenter?.deleteFavorite(index: index ?? 0)
            } else {
                presenter?.saveFavorite(index: index ?? 0)
            }
        } else {
            //searchPresenter?.getMovieSearch(endPoint: .trending)
        }
        
    }
    
}
