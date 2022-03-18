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
    
//    func time() {
//        let date = DateFormatter()
//        date.locale = Locale(identifier: "he_IL")
//        date.timeZone = TimeZone(identifier: TimeZone.current.identifier)
//        date.dateFormat = "HH:mm"
//        print(date.string(from: Date()))
//    }

    

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

//        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
//        time()
        
        // StatusBar에 Alamofire 시도 중 Indicator 띄워주기 위한 옵션 설정
//        NetworkActivityIndicatorManager.shared.isEnabled = true
        
        
        IQKeyboardManager.shared.enable = true
        
//        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
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


}

