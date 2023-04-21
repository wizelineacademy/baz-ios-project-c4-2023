//
//  UIViewControllerSpy.swift
//  BAZProjectTests
//
//  Created by 989438 on 20/04/23.
//

import UIKit

enum UIViewControllerSpyCalls {
    case present
}
final class UIViewControllerSpy: UIViewController {
    var calls: [UIViewControllerSpyCalls] = []
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        calls.append(.present)
    }
}
