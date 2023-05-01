//
//  MediaItemTableViewCell.swift
//  BAZProject
//
//  Created by gescarcega on 01/05/23.
//

import UIKit

class MediaItemTableViewCell: UITableViewCell {

    func setCell(with model: MediaTableViewCellModel) {
        Task {
            imageView?.image = try? await UIImage(download: model.image ?? "") ?? UIImage(named: model.defaultImage ?? "")
        }
        textLabel?.text = model.title
        detailTextLabel?.text = model.subtitle
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }
    
}
