//
//  MovieItemCell.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 30/03/23.
//

import Foundation
import UIKit

class MovieItemCell: ReusableTableViewCell<Movie>{

    // MARK: - Variables

    // MARK: - Input/View and Constraints

    private lazy var imgvPorter:UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleToFill
        imgv.translatesAutoresizingMaskIntoConstraints = false
        return imgv
    }()

    private func imgvPorterConstraints(){
        addSubview(imgvPorter)
        imgvPorter.widthAnchor.constraint(equalToConstant: 75).isActive = true
        imgvPorter.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imgvPorter.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        imgvPorter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
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
        lblTitle.leadingAnchor.constraint(equalTo: imgvPorter.trailingAnchor, constant: 8).isActive = true
        lblTitle.centerYAnchor.constraint(equalTo: imgvPorter.centerYAnchor).isActive = true
    }


    // MARK: - Override Functions/Variables

    override var item: Movie!{
        didSet {
            imgvPorter.image = UIImage(named: "poster")
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
