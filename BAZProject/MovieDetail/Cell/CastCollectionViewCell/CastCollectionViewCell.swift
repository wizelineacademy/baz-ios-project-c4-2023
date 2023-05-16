//
//  CastCollectionViewCell.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 05/05/23.
//

import UIKit

final class CastCollectionViewCell: UICollectionViewCell {
    
    ///UILabel que despliega el nombre de un actor 
    @IBOutlet weak var lblName: UILabel!
    
    ///UIImageView que despliega la imagen de un actor
    @IBOutlet weak var imgActor: UIImageView!
    
    
    static var idetifier: String{
        return String(describing: self)
    }
    ///String que regresa el identificador de celda
    override func prepareForReuse() {
        super.prepareForReuse()
        imgActor.image =  UIImage(systemName: "person")
        lblName.text = ""
    }

}
