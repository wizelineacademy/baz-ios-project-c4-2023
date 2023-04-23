//
//  TitleCollectionReusableView.swift
//  BAZProject
//
//  Created by ksolano on 21/04/23.
//

import UIKit

// Cell for custom secctions in a Collection View
class TitleCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var titleSectionLabel: UILabel!
    
    var titleLabel: String = "" {
        didSet{
            titleSectionLabel.text = titleLabel
        }
    }
    
}
