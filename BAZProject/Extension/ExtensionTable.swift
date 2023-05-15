//
//  ExtensionTable.swift
//  BAZProject
//
//  Created by nmorenoa on 08/05/23.
//

import Foundation
import UIKit

extension UITableViewCell {
    class var identifier: String { return String(describing: self) }
}
extension UICollectionViewCell{
    class var identifier: String { return String(describing: self) }
}
extension UIImageView{
    func download(poster_path: String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster_path)") else { return }
        let globalQueue = DispatchQueue.global()
        globalQueue.async {
            if let data = try? Data(contentsOf: url){
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
    
    func makeRounded() {
        self.contentMode = .scaleAspectFill
        layer.cornerRadius = self.frame.width / 2
        layer.masksToBounds = false
        clipsToBounds = true
    }
}
