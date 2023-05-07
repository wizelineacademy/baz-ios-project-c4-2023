//
//  TitleSectionCollectionReusableView.swift
//  BAZProject
//
//  Created by Ben Frank V. on 06/05/23.
//

import UIKit

class TitleSectionCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var lblTitle: UILabel!
    
    func setup(title: String){
        lblTitle.text = title
    }

     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

     }
    
}

extension UICollectionReusableView {
    class var identifier: String { return String(describing: self) }
   
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: .main)
    }
    
}
