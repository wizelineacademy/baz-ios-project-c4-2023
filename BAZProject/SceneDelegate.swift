//
//  SceneDelegate.swift
//  BAZProject
//
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowsScene)
        let movieApi = MovieAPI(session: URLSession.shared)
        let viewController = TrendingViewController.instantiate()
        viewController?.movieApi = movieApi
        let navigation = UINavigationController(rootViewController: viewController ?? UIViewController())
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
    }

}

