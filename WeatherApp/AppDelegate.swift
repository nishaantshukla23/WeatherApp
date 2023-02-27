//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by N Shukla on 24/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let mainNavigationVC = UINavigationController()
        coordinator = Coordinator(navigationController: mainNavigationVC)
        coordinator?.start()
        window?.rootViewController = mainNavigationVC
        return true
    }

}

