//
//  SearchMovieItemAdapter.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 27/04/23.
//

import Foundation
import UIKit

// MARK: - Class
class SearchMovieItemAdapter: ReusableTableViewCell<Movie> {

    // MARK: - Input/View and Constraints

    private lazy var imgvPorter: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFit
        imgv.translatesAutoresizingMaskIntoConstraints = false
        return imgv
    }()

    private func imgvPorterConstraints() {
        addSubview(imgvPorter)
        imgvPorter.topAnchor.constraint(equalTo: topAnchor, constant: .dim8).isActive = true
        imgvPorter.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.dim8).isActive = true
        imgvPorter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .dim8).isActive = true
        imgvPorter.widthAnchor.constraint(equalToConstant: .dim75).isActive = true
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
        lblTitleMovie.topAnchor.constraint(equalTo: imgvPorter.topAnchor, constant: .dim8).isActive = true
        lblTitleMovie.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.dim8).isActive = true
        lblTitleMovie.leadingAnchor.constraint(equalTo: imgvPorter.trailingAnchor, constant: .dim8).isActive = true
    }

    // MARK: - Override Functions/Variables

    override var item: Movie! {
        didSet {
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
