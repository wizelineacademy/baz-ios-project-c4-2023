//
//  ActorItemAdapter.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation
import UIKit

class ActorItemAdapter: ReusableCollectionViewCell<Actor> {

    // MARK: - Input/View and Constraints

    private lazy var imgvProfile: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFit
        imgv.translatesAutoresizingMaskIntoConstraints = false
        return imgv
    }()

    private func imgvProfileConstraints() {
        addSubview(imgvProfile)
        imgvProfile.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgvProfile.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imgvProfile.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgvProfile.heightAnchor.constraint(equalToConstant: .dim120).isActive = true
    }

    private lazy var lblNameActor: UILabel = {
        let lbl = UILabel()
        let sizeFont: CGFloat = .dim16
        lbl.font = UIFont(name: "ArialNarrow", size: sizeFont)
        lbl.font = UIFont.boldSystemFont(ofSize: sizeFont)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private func lblNameActorConstraints() {
        addSubview(lblNameActor)
        lblNameActor.centerXAnchor.constraint(equalTo:  centerXAnchor).isActive = true
        lblNameActor.topAnchor.constraint(equalTo: imgvProfile.bottomAnchor, constant: .dim4).isActive = true
        lblNameActor.trailingAnchor.constraint(equalTo:  trailingAnchor, constant: -.dim4).isActive = true
        lblNameActor.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: .dim4).isActive = true
    }

    private lazy var lblCharacterActor: UILabel = {
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

    private func lblCharacterActorConstraints() {
        addSubview(lblCharacterActor)
        lblCharacterActor.centerXAnchor.constraint(equalTo:  centerXAnchor).isActive = true
        lblCharacterActor.topAnchor.constraint(equalTo: lblNameActor.bottomAnchor, constant: .dim4).isActive = true
        lblCharacterActor.trailingAnchor.constraint(equalTo:  trailingAnchor, constant: -.dim4).isActive = true
        lblCharacterActor.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: .dim4).isActive = true
    }

    // MARK: - Override Functions/Variables

    override var item: Actor!{
        didSet{
            let placeHolder = UIImage(named: "poster")
            let posterPath = "\(Consts.END_POINTS.POSTER_PATH)\(item.profile_path)"
            imgvProfile.loadAsync(from: posterPath.toUrl(), placeHolder: placeHolder)
            lblNameActor.text = item.name
            lblCharacterActor.text = item.character
        }
    }

    override func setupViews() {
        super.setupViews()
        imgvProfileConstraints()
        lblNameActorConstraints()
        lblCharacterActorConstraints()
    }
}
