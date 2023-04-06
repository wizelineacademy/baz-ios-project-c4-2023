//
//  MovieItemCell.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 30/03/23.
//

import Foundation
import UIKit

class MovieItemCell: ReusableTableViewCell<Movie>{

    // MARK: - Input/View and Constraints

    private lazy var imgvPorter:UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleToFill
        imgv.translatesAutoresizingMaskIntoConstraints = false
        return imgv
    }()

    private func imgvPorterConstraints(){
        addSubview(imgvPorter)
        imgvPorter.widthAnchor.constraint(equalToConstant: .dim75).isActive = true
        imgvPorter.heightAnchor.constraint(equalToConstant: .dim100).isActive = true
        imgvPorter.topAnchor.constraint(equalTo: topAnchor, constant: .dim4).isActive = true
        imgvPorter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .dim8).isActive = true
    }

    private lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "ArialNarrow", size: 20)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private func lblTitleConstraints(){
        addSubview(lblTitle)
        lblTitle.leadingAnchor.constraint(equalTo: imgvPorter.trailingAnchor, constant: .dim8).isActive = true
        lblTitle.centerYAnchor.constraint(equalTo: imgvPorter.centerYAnchor).isActive = true
    }


    // MARK: - Override Functions/Variables

    override var item: Movie! {
        didSet {
            let placeHolder = UIImage(named: "poster")
            let posterPath = "\(Consts.END_POINTS.POSTER_PATH)\(item.poster_path)"
            imgvPorter.loadAsync(from: posterPath.toUrl(), placeHolder: placeHolder)
            lblTitle.text = item.title
        }
    }

    override func setupViews() {
        super.setupViews()
        self.selectionStyle = .none
        imgvPorterConstraints()
        lblTitleConstraints()
    }
}
