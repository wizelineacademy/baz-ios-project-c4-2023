//
//  MovieItemAdapter.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 15/04/23.
//

import Foundation
import UIKit

// MARK: - Class
class MovieItemAdapter: ReusableCollectionViewCell<Movie> {

    // MARK: - Input/View and Constraints

    private lazy var imgvPorter: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFit
        imgv.translatesAutoresizingMaskIntoConstraints = false
        return imgv
    }()

    private func imgvPorterConstraints() {
        addSubview(imgvPorter)
        imgvPorter.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgvPorter.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imgvPorter.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgvPorter.heightAnchor.constraint(equalToConstant: .dim150).isActive = true
    }

    private lazy var lblTitleMovie: UILabel = {
        let lbl = UILabel()
        let sizeFont: CGFloat = .dim12
        lbl.font = UIFont(name: "ArialNarrow", size: sizeFont)
        lbl.font = UIFont.systemFont(ofSize: sizeFont)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private func lblTitleMovieConstraints() {
        addSubview(lblTitleMovie)
        lblTitleMovie.centerXAnchor.constraint(equalTo:  centerXAnchor).isActive = true
        lblTitleMovie.topAnchor.constraint(equalTo: imgvPorter.bottomAnchor, constant: .dim4).isActive = true
        lblTitleMovie.trailingAnchor.constraint(equalTo:  trailingAnchor, constant: -.dim4).isActive = true
        lblTitleMovie.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: .dim4).isActive = true
    }

    // MARK: - Override Functions/Variables

    override var item: Movie!{
        didSet{
            let placeHolder = UIImage(named: "poster")
            let posterPath = "\(Consts.END_POINTS.POSTER_PATH)\(item.posterPath ?? "")"
            imgvPorter.loadAsync(from: posterPath.toUrl(), placeHolder: placeHolder)
            lblTitleMovie.text = item.title
        }
    }

    override func setupViews() {
        super.setupViews()
        imgvPorterConstraints()
        lblTitleMovieConstraints()
    }
}
