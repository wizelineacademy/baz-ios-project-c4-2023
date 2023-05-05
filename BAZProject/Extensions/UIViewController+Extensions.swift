//
//  UIViewController+Extensions.swift
//  BAZProject
//
//  Created by Carlos Garcia on 03/05/23.
//

import UIKit

extension UIViewController {
    func addRightButton(imageName: String, action: Selector?, color: UIColor?) {
        let button = UIBarButtonItem(image: UIImage(systemName: imageName), style: .plain, target: self, action: action)
        if let color = color {
            button.tintColor = color
        }
        navigationItem.rightBarButtonItem = button
    }
    
    func addRightButton(title: String? = nil, imageName: String? = nil, action: Selector?) {
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        button.tintColor = .black
        navigationItem.rightBarButtonItem = button
    }
}
