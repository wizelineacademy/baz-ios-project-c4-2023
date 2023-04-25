//
//  GeneralTableViewCell.swift
//  BAZProject
//
//  Created by Ben Frank V. on 24/04/23.
//

import UIKit

protocol GeneralTableViewCellProtocol {
    func setup(_ movie : Movie?)
    func getPoster(_ path: String)
}

class GeneralTableViewCell: BMTableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    
    func setup(_ movie : Movie?){
        lblTitle.text = movie?.title
        getPoster(movie?.poster_path ?? "")
    }
    
    func getPoster(_ path: String){
        GetImage.getImage(pathPoster: path) { image in
            DispatchQueue.main.async { [weak self] in
                if let poster = image {
                    self?.imgPoster.image = poster
                }else{
                    self?.imgPoster.image = UIImage(named: "poster")
                }
                
            }
            
        }
    }
    
}

extension GeneralTableViewCellProtocol{}
