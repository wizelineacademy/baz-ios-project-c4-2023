//
//  MovieCollectionViewCell.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 04/05/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    
    
    static var idetifier: String{
        return String(describing: self)
    }

}
