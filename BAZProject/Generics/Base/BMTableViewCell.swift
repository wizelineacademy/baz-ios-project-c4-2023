//
//  BMTableViewCell.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//

import UIKit

class BMTableViewCell: UITableViewCell {
    var cellDataModel: BMTableViewCellProtocol? {
        didSet {
            setUIData()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setUIData()
    }
    
    func setUIData() {}
    
}

protocol BMTableViewCellProtocol {
    func setUIData()
}

extension UITableViewCell {
    class var identifier: String { return String(describing: self) }
   
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: .main)
    }
    
}
