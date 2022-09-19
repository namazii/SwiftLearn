//
//  AppDelegate.swift
//  Quizi
//
//  Created by Назар Ткаченко on 05.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import FirebaseAnalytics
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions) { _, _ in }
        application.registerForRemoteNotifications()
        return true
    }

//    private func process(_ notification: UNNotification) {
//      // 1
//      let userInfo = notification.request.content.userInfo
//      // 2
//      UIApplication.shared.applicationIconBadgeNumber = 0
////      if let newsTitle = userInfo["newsTitle"] as? String,
////        let newsBody = userInfo["newsBody"] as? String {
////        let newsItem = NewsItem(title: newsTitle, body: newsBody, date: Date())
////        NewsModel.shared.add([newsItem])
////      }
//    }

    
    //MARK: Lock Orientation
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void
    ) {
//        process(notification)
        completionHandler([[.banner, .sound]])
    }
    
    //получение токена
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
//        process(response.notification)

        completionHandler()
    }
    //регистрация на получение девайс токена
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
}

extension AppDelegate: MessagingDelegate {
  func messaging(
    _ messaging: Messaging,
    didReceiveRegistrationToken fcmToken: String?
  ) {
      print("FCM Token ->", fcmToken ?? "")
    let tokenDict = ["token": fcmToken ?? ""]
    NotificationCenter.default.post(
      name: Notification.Name("FCMToken"),
      object: nil,
      userInfo: tokenDict)
  }
}


