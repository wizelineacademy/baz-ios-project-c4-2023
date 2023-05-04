//
//  UIVIewControllerSpy.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import Foundation

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
