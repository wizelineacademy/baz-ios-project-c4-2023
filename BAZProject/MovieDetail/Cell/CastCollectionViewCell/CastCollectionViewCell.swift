//
//  CastCollectionViewCell.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 05/05/23.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgActor: UIImageView!
    
    
    static var idetifier: String{
        return String(describing: self)
    }

}
