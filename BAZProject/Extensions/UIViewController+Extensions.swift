//
//  UIViewController+Extensions.swift
//  BAZProject
//
//  Created by Carlos Garcia on 03/05/23.
//

import UIKit

extension UIViewController {
    /**
     Add the right image button in navigation bar.
     
     The contents of this property always refer to the first bar button item in the rightBarButtonItems array.
     
     - Parameters:
        - imageName: String name of the system image.
        - action: The action to send to target when this item is selected.
        - color: Tint button color.
     */
    func addRightButton(imageName: String, action: Selector?, color: UIColor?) {
        let button = UIBarButtonItem(image: UIImage(systemName: imageName), style: .plain, target: self, action: action)
        if let color = color {
            button.tintColor = color
        }
        navigationItem.rightBarButtonItem = button
    }
    
    /**
     Add the right text button in navigation bar.
     
     The contents of this property always refer to the first bar button item in the rightBarButtonItems array.
     
     - Parameters:
        - title: The item’s title. If nil a title is not displayed..
        - action: The action to send to target when this item is selected.
     */
    func addRightButton(title: String? = nil, action: Selector?) {
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        button.tintColor = .black
        navigationItem.rightBarButtonItem = button
    }
}
