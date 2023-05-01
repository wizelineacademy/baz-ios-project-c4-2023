//
//  CategoriesMenuCollectionViewCell.swift
//  BAZProject
//
//  Created by ksolano on 27/04/23.
//

import UIKit

class CategoriesMenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoriesLabel: UILabel!
    
    var categoriesLabelText: String = "" {
        didSet{
            categoriesLabel.text = categoriesLabelText
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoriesLabel.text = nil
    }
    
    
}
