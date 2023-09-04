//
//  AppDelegate.swift
//  vlogsApp
//
//  Created by Petar Popovski on 1.6.23.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        lazy var db = Firestore.firestore()
        
        
        SDImageCache.shared.config.maxMemoryCost = 1024 * 1024 * 20
        SDImageCache.shared.config.maxDiskAge = TimeInterval(60 * 60 * 24 * 7)
        SDImageCache.shared.config.maxDiskSize = 1024 * 1024 * 200

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

