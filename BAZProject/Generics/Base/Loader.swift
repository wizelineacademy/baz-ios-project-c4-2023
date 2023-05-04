//
//  Loader.swift
//  BAZProject
//
//  Created by Ben Frank V. on 03/05/23.
//

import UIKit

public class Loader{
    
    internal static var spinner: UIActivityIndicatorView?
    static var style: UIActivityIndicatorView.Style = .large
    static var baseBackColor = UIColor(white: 0, alpha: 0.6)
    static var baseColor = UIColor(red: 157, green: 196, blue: 157, alpha: 1.0)
    
    static func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        if spinner == nil, let window = UIApplication.shared.windows.last(where: { $0.isKeyWindow }) {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner!.backgroundColor = backColor
            spinner!.style = style
            spinner?.color = baseColor
            window.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    
    static func stop() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
    
    static func update() {
        if spinner != nil {
            stop()
            start()
        }
    }
    
}
