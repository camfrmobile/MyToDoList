//
//  AppDelegate.swift
//  MyToDoList
//
//  Created by Trần Văn Cam on 17/11/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let viewController = MainTabBarController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        
        return true
    }


}

