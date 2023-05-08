//
//  MovieCollectionViewCell.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 04/05/23.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    
    ///UILabel que despliega el nombre de una pelicula
    @IBOutlet weak var lblTitle: UILabel!
    
    ///UIImageView que despliega la imagen de una pelicula
    @IBOutlet weak var imgPoster: UIImageView!
    
    ///String que regresa el identificador de celda
    static var idetifier: String{
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgPoster.image =  UIImage(systemName: "person")
        lblTitle.text = ""
    }

}
