//
//  ReviewItemAdapter.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 17/04/23.
//

import Foundation
import UIKit

class ReviewItemAdapter: ReusableTableViewCell<Review> {

    // MARK: - Override Functions/Variables

    private lazy var lblAuthorReview: UILabel = {
        let lbl = UILabel()
        let sizeFont: CGFloat = .dim20
        lbl.font = UIFont(name: "ArialNarrow", size: sizeFont)
        lbl.font = UIFont.boldSystemFont(ofSize: sizeFont)
        lbl.textColor = .black
        lbl.numberOfLines = 1
        //lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private func lblAuthorReviewConstraints() {
        addSubview(lblAuthorReview)
        lblAuthorReview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lblAuthorReview.trailingAnchor.constraint(equalTo:  trailingAnchor).isActive = true
        lblAuthorReview.leadingAnchor.constraint(equalTo:  leadingAnchor).isActive = true
    }

    private lazy var lblContentReview: UILabel = {
        let lbl = UILabel()
        let sizeFont: CGFloat = .dim16
        lbl.font = UIFont(name: "ArialNarrow", size: sizeFont)
        lbl.font = UIFont.systemFont(ofSize: sizeFont)
        lbl.textColor = .gray
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private func lblContentReviewConstraints() {
        addSubview(lblContentReview)
        lblContentReview.topAnchor.constraint(equalTo: lblAuthorReview.bottomAnchor, constant: .dim4).isActive = true
        lblContentReview.trailingAnchor.constraint(equalTo:  trailingAnchor).isActive = true
        lblContentReview.leadingAnchor.constraint(equalTo:  leadingAnchor).isActive = true
    }

    private lazy var imgvStar: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFit
        imgv.tintColor = .yellow
        imgv.image = UIImage(systemName: "star.fill")
        imgv.translatesAutoresizingMaskIntoConstraints = false
        return imgv
    }()

    private func imgvStarConstraints() {
        addSubview(imgvStar)
        imgvStar.topAnchor.constraint(equalTo: lblContentReview.bottomAnchor, constant: .dim4).isActive = true
        imgvStar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgvStar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.dim4).isActive = true
    }

    private lazy var lblRatingReview: UILabel = {
        let lbl = UILabel()
        let sizeFont: CGFloat = .dim18
        lbl.font = UIFont(name: "ArialNarrow", size: sizeFont)
        lbl.font = UIFont.boldSystemFont(ofSize: sizeFont)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private func lblRatingReviewConstraints() {
        addSubview(lblRatingReview)
        lblRatingReview.centerYAnchor.constraint(equalTo: imgvStar.centerYAnchor).isActive = true
        lblRatingReview.leadingAnchor.constraint(equalTo:  imgvStar.trailingAnchor, constant: .dim4).isActive = true
    }

    private lazy var lblDateReview: UILabel = {
        let lbl = UILabel()
        let sizeFont: CGFloat = .dim16
        lbl.font = UIFont(name: "ArialNarrow", size: sizeFont)
        lbl.font = UIFont.systemFont(ofSize: sizeFont)
        lbl.textColor = .gray
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private func lblDateReviewConstraints() {
        addSubview(lblDateReview)
        lblDateReview.centerYAnchor.constraint(equalTo: imgvStar.centerYAnchor).isActive = true
        lblDateReview.trailingAnchor.constraint(equalTo:  trailingAnchor, constant: -.dim8).isActive = true
    }

    override var item: Review!{
        didSet{
            lblAuthorReview.text = item.author
            var content = item.content
            if item.content.count > 100 {
                content = String(item.content.prefix(100)) + "..."
            }
            lblContentReview.text = content
            lblRatingReview.text = "\(item.rating ?? 0)"
            lblDateReview.text = item.createdAt
        }
    }

    override func setupViews() {
        super.setupViews()
        lblAuthorReviewConstraints()
        lblContentReviewConstraints()
        imgvStarConstraints()
        lblRatingReviewConstraints()
        lblDateReviewConstraints()
    }
}
