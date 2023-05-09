//
//  GreenLabel.swift
//  BAZProject
//
//  Created by jehernandezg on 01/05/23.
//

import UIKit

class GreenLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit(){
        self.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.sizeToFit()
        self.textColor = UIColor.AppColors.labelGreen
    }
}
