//
//  UIViewExtensions.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 15/04/23.
//

import Foundation
import UIKit

extension UIView {

    func removeConstraints() {
        let constraints = self.superview?.constraints.filter{
            $0.firstItem as? UIView == self || $0.secondItem as? UIView == self
        } ?? []
        self.superview?.removeConstraints(constraints)
        self.removeConstraints(self.constraints)
    }
}

extension UITableView {
    
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
    
    func setEmptyMessage(_ message: String) {
        self.backgroundView = lblEmptyText(msg: message);
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

extension UICollectionView {

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
    
    func setEmptyMessage(_ message: String) {
        self.backgroundView = lblEmptyText(msg: message);
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
