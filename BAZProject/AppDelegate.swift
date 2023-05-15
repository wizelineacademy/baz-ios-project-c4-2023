//
//  AppDelegate.swift
//  BAZProject
//
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
            let auth = Auth(apiKey: apiKey)
            KeychainHelper.standard.save(auth)
        }
        
        return true
    }
}

