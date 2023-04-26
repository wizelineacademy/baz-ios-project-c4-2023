//
//  UIViewController+Extensions.swift
//  BAZProject
//
//  Created by jmgarciaca on 17/04/23.
//

import UIKit

extension UIViewController {

    /**
    Configures the navigation bar appearance with the provided colors and title.

    Parameters:
    largeTitleColor: The color of the large title text.
    backgoundColor: The color of the navigation bar background.
    tintColor: The tint color of the navigation bar buttons.
    title: The title of the navigation bar.
    preferredLargeTitle: A Boolean value indicating whether the navigation bar prefers a large title.
    Note: This function uses the UINavigationBarAppearance class introduced in iOS 13.0.
    Returns: Void
    */
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.backgroundColor = backgoundColor

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

            navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = tintColor
            navigationItem.title = title

        }
    }
}
