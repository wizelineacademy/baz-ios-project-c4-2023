//
//  CellMovies.swift
//  BAZProject
//
//  Created by nmorenoa on 17/04/23.
//

import UIKit

final class CellMovies: UITableViewCell{
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var descriptionMovie: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgMovie.image = nil
    }
    
}
