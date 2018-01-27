//
//  AppDelegate.swift
//  YouTube
//
//  Created by James Haville on 07/01/2018.
//  Copyright © 2018 James Haville. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.rootViewController = UINavigationController(rootViewController: HomeController(videoService: VideoServiceImpl(), homeDataSource: HomeDataSource()))
    
    UINavigationBar.appearance().barTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
    application.statusBarStyle = .lightContent
    
    return true
  }

}


