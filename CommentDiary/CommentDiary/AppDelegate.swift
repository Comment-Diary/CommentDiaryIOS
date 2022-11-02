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
import IQKeyboardManagerSwift
import UserNotifications
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //MARK: - PushAlert
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        //FCM 현재 등록 토큰 확인
        Messaging.messaging().token { token, error in
            if let error = error {
                print("ERROR FCM 토큰 가져오기 \(error.localizedDescription)")
            } else if let token = token {
                print("FCM 등록토큰 \(token)")
            }
        }
        
        
        
        //특정페이지 이동
        let userNotificationCenter = UNUserNotificationCenter.current()
        
        
        userNotificationCenter.delegate = self
        application.registerForRemoteNotifications()
        
        
        let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, error in
            print("ERROR, Request Notifications Authorization: \(error.debugDescription)")
        }
        application.registerForRemoteNotifications()
        
        
        
        

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

extension AppDelegate: UNUserNotificationCenterDelegate {
 
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        
        completionHandler([.alert, .sound, .badge])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)

        
        
        let application = UIApplication.shared
        print(response.notification.request.content.title, "제목값")
        
        enum fcmTitle: String {
            case arrivalComment = "코멘트가 도착했어요"
            case writeComment = "하이하이"
            
        }

        
//        func fcmTitleCase() {
//            guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else { return }
//            let gatherLookStoryboard = UIStoryboard(name: "GatherLookDetail", bundle: nil)
//
//            switch response.notification.request.content.title {
//            case fcmTitle.arrivalComment.rawValue:
//                print("코멘트가 도착했어요")
//                NotificationCenter.default.post(name: Notification.Name("arrivalCommentFCM"), object: nil)
//                let gatherLookDetailVC = gatherLookStoryboard.instantiateViewController(withIdentifier: "GatherLookDetailViewController") as! GatherLookDetailViewController
//                let navVC = rootViewController as? UINavigationController
//                navVC?.pushViewController(gatherLookDetailVC, animated: true)
//
//            case fcmTitle.writeComment.rawValue:
//                print("2")
//                NotificationCenter.default.post(name: Notification.Name("writeCommentFCM"), object: nil)
//            default:
//                print("예외")
//            }
//        }

        switch application.applicationState {
            //앱이 켜져있는 상태에서 푸쉬 알림 눌렀을 때
        case .inactive:
//            fcmTitleCase()
            print("inactive")
            
            if response.notification.request.content.title == "코멘트가 도착했어요" {
                guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else { return }
                let gatherLookStoryboard = UIStoryboard(name: "GatherLookDetail", bundle: nil)
                let gatherLookDetailVC = gatherLookStoryboard.instantiateViewController(withIdentifier: "GatherLookDetailViewController") as! GatherLookDetailViewController
                let navVC = rootViewController as? UINavigationController
//                let tabBarVC = navVC?.viewControllers.first
//                tabBarVC?.pushViewController(gatherLookDetailVC, animated: true)
                
                
//                navVC?.viewControllers.first?.present(gatherLookDetailVC, animated: true)

            }
            
            //앱이 꺼져있는 상태에서 푸쉬알림 눌렀을 때
        case .active:
//            fcmTitleCase()
            print("active")
            
        case .background:
//            fcmTitleCase()
            print("background")
        default:
            break
        }
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let token = fcmToken else { return }
        print("FCM 등록토큰 갱신 \(token)")
        
        //토큰 저장
        UserDefaults.standard.set(token, forKey: "deviceToken")
        
    }
}


