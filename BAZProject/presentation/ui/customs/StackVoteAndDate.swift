//
//  StackVoteAndDate.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation
import UIKit

class StackVoteAndDate: UIStackView {

    private var voteAverange: Float
    private var releaseDate: String

    private lazy var lblVoteAverangeMovie: UILabel = {
        return setupLabel(text: "Voto Promedio: \(voteAverange)")
    }()

    private lazy var lblReleaseDateMovie: UILabel = {
        return setupLabel(text: "Fecha de lanzamiento: \(releaseDate.formatReleaseDate())")
    }()

    init(voteAverange: Float, releaseDate: String) {
        self.voteAverange = voteAverange
        self.releaseDate = releaseDate
        super.init(frame: .zero)
        setupViews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabel(text: String) -> UILabel {
        let lbl = UILabel()
        let sizeFont: CGFloat = .dim16
        lbl.font = UIFont(name: "ArialNarrow", size: sizeFont)
        lbl.font = UIFont.boldSystemFont(ofSize: sizeFont)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.text = text
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }

    private func setupViews() {
        self.axis = .horizontal
        addArrangedSubview(lblReleaseDateMovie)
        addArrangedSubview(lblVoteAverangeMovie)
    }
}
