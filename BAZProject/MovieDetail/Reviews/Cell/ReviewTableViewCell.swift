//
//  ReviewTableViewCell.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import UIKit

final class ReviewTableViewCell: UITableViewCell {
    
    ///UIImageView que despliega el avatar de un usuario
    @IBOutlet weak var imageAuthor: UIImageView!
    
    ///UILabel que despliega el nombre del usuario
    @IBOutlet weak var lblAuthorName: UILabel!
    
    ///UILabel que despliega informacion extra
    @IBOutlet weak var lblDescription: UILabel!
    
    ///UILabel que despliega la reseña de un usuario
    @IBOutlet weak var lblReview: UILabel!
    
    ///String que regresa el identificador de celda
    static var identifier: String{
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageAuthor.image =  UIImage(systemName: "person")
        lblAuthorName.text = ""
        lblDescription.text = ""
        lblReview.text = ""
    }
}
