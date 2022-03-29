//
//  AppDelegate.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/12.
//

import UIKit
//import AlamofireNetworkActivityIndicator
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        UITabBar.appearance().tintColor = UIColor(hex: 0x4E4C49)
        UITabBar.appearance().barTintColor = UIColor(hex: 0xF4F1Eb)
//        UITabBar.appearance().unselectedItemTintColor = UIColor(hex: <#T##UInt#>)
//        self.window?.overrideUserInterfaceStyle = .light
 
//        self.window?.overrideUserInterfaceStyle = .light

        IQKeyboardManager.shared.enable = true
        

        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
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

//    func refresh() {
//        TokenRefreshDataManager().tokenRefreshPostData()
//    }

}

