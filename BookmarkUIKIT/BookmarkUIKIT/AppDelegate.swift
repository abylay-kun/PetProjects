//
//  AppDelegate.swift
//  BookmarkUIKIT
//
//  Created by Abylay Duzel on 02.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
 var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
       
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
//       window?.rootViewController = testApi()
        window?.makeKeyAndVisible()

        return true
    }

   


}

