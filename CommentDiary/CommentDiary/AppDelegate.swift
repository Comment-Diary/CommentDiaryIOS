//
//  AppDelegate.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/12.


//https://madilyn.tistory.com/23?category=833875
//ios 15 텝바
//

import UIKit
import Siren
//import AlamofireNetworkActivityIndicator
import IQKeyboardManagerSwift
//save

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.


        if #available(iOS 13.0, *) {
            UITabBar.appearance().isTranslucent = false
            UITabBar.appearance().tintColor = UIColor(hex: 0x4E4C49)
            UITabBar.appearance().backgroundColor = UIColor(hex: 0xF4F1EB)
        }

        if #available(iOS 14.0, *) {
            UITabBar.appearance().isTranslucent = false
            UITabBar.appearance().tintColor = UIColor(hex: 0x4E4C49)
            UITabBar.appearance().backgroundColor = UIColor(hex: 0xF4F1EB)
        }
        
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            let tabBar = UITabBar()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(hex: 0xF4F1EB)
            tabBar.standardAppearance = appearance;
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        //업데이트
        window?.makeKeyAndVisible()
        let siren = Siren.shared
        siren.apiManager = APIManager(country: .korea)
        siren.presentationManager = PresentationManager(forceLanguageLocalization: .korean)
        siren.rulesManager = RulesManager(majorUpdateRules: .critical, minorUpdateRules: .critical, patchUpdateRules: .critical, revisionUpdateRules: .critical)
        siren.wail()

        
        

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        return true
    }
    
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        // 세로방향 고정
//        return UIInterfaceOrientationMask.portrait
//    }

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

