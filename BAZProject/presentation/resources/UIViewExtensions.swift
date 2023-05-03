//
//  UIViewExtensions.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 15/04/23.
//

import Foundation
import UIKit

extension UITableView {

    /**
     Crea un UILabel para mostrar un mensaje que se configura desde el dataSource del UITableView
     */
    private func lblEmptyText(msg: String) -> UILabel {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        let sizeFont: CGFloat = .dim16
        messageLabel.text = msg
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "ArialNarrow", size: sizeFont)
        messageLabel.font = UIFont.boldSystemFont(ofSize: sizeFont)
        messageLabel.sizeToFit()
        return messageLabel
    }
    
    /**
     Asi el texto al UILabel
     */
    func setEmptyMessage(_ message: String) {
        self.backgroundView = lblEmptyText(msg: message);
        self.separatorStyle = .none;
    }
    
    /**
     Vacia el backgroundView del UITableView
     */
    func restore() {
        self.backgroundView = nil
    }
}

extension UICollectionView {

    /**
     Crea un UILabel para mostrar un mensaje que se configura desde el dataSource del UICollectionView
     */
    private func lblEmptyText(msg: String) -> UILabel {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        let sizeFont: CGFloat = .dim16
        messageLabel.text = msg
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "ArialNarrow", size: sizeFont)
        messageLabel.font = UIFont.boldSystemFont(ofSize: sizeFont)
        messageLabel.sizeToFit()
        return messageLabel
    }

    /**
     Asi el texto al UILabel
     */
    func setEmptyMessage(_ message: String) {
        self.backgroundView = lblEmptyText(msg: message);
    }

    /**
     Vacia el backgroundView del UICollectionView
     */
    func restore() {
        self.backgroundView = nil
    }
}
