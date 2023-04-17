//
//  NavigationControllerSpy.swift
//  BAZProjectTests
//
//  Created by 989438 on 30/03/23.
//

import UIKit

final class NavigationControllerSpy: UINavigationController {
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        self.pushedViewController = viewController
    }
}
