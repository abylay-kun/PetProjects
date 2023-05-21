//
//  AppDelegate.swift
//  testApi
//
//  Created by Abylay Duzel on 11.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
       
        //window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()

        return true
    }

   

}

