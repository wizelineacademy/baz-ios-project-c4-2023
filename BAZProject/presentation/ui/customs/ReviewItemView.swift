//
//  ReviewItemView.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 04/05/23.
//

import Foundation
import UIKit

// MARK: - Class
class ReviewItemView: UIView {

    // MARK: - Properties
    private var review: Review

    // MARK: - Override Functions/Variables

    private lazy var lblAuthorReview: UILabel = {
        let lbl = UILabel()
        let sizeFont: CGFloat = .dim20
        lbl.font = UIFont(name: "ArialNarrow", size: sizeFont)
        lbl.font = UIFont.boldSystemFont(ofSize: sizeFont)
        lbl.textColor = .black
        lbl.numberOfLines = 1
        // lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private func lblAuthorReviewConstraints() {
        addSubview(lblAuthorReview)
        lblAuthorReview.text = review.author
        lblAuthorReview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lblAuthorReview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lblAuthorReview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
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

        if review.content.count > 100 {
            lblContentReview.text = String(review.content.prefix(100)) + "..."
        } else {
            lblContentReview.text = review.content
        }
        lblContentReview.topAnchor.constraint(equalTo: lblAuthorReview.bottomAnchor, constant: .dim4).isActive = true
        lblContentReview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lblContentReview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
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
        lblRatingReview.text = "\(review.rating ?? 0)"
        lblRatingReview.centerYAnchor.constraint(equalTo: imgvStar.centerYAnchor).isActive = true
        lblRatingReview.leadingAnchor.constraint(equalTo: imgvStar.trailingAnchor, constant: .dim4).isActive = true
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
        let createdAt = String(review.createdAt.prefix(10))
        lblDateReview.text = createdAt.formatReleaseDate()
        lblDateReview.centerYAnchor.constraint(equalTo: imgvStar.centerYAnchor).isActive = true
        lblDateReview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.dim8).isActive = true
        bottomAnchor.constraint(equalTo: lblDateReview.bottomAnchor, constant: -.dim12).isActive = true
    }

    init(review: Review) {
        self.review = review
        super.init(frame: .zero)
        setupViews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        lblAuthorReviewConstraints()
        lblContentReviewConstraints()
        imgvStarConstraints()
        lblRatingReviewConstraints()
        lblDateReviewConstraints()
    }
}
