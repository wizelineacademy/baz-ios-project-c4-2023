//
//  DetailOverviewCollectionViewCell.swift
//  BAZProject
//
//  Created by gescarcega on 06/05/23.
//

import UIKit

class DetailOverviewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var subtitleLable: UILabel!
    @IBOutlet private(set) weak var posterImage: UIImageView!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    
    func setCell(with model: DetailOverview, session: RequestSessionProtocol = URLSession.shared) {
        titleLabel.text = model.largeTitle
        subtitleLable.text = model.smallSubtitle
        descriptionLabel.text = model.description
        if let defaultImage = model.defaultImage {
            posterImage.image = UIImage(named: defaultImage)
        }
        if let imagePath = model.image {
            Task {
                posterImage.image = try await UIImage(endpoint: ImageEndpoint(path: imagePath), session: session)
            }
        }
    }
}
