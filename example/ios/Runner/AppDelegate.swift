import UIKit
import Flutter

//PPSDK機能
import ProfilePassportCore
//通知機能(通知機能を利用しない場合は必要なし)
import ProfilePassportNotice
//ビーコン機能(ビーコン機能を利用しない場合は必要なし)
import ProfilePassportBeacon

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, UNUserNotificationCenterDelegate {
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        //PPSDKの初期化処理（必須）
        UNUserNotificationCenter.current().delegate = self
        PPSDKManager.shared.initializeSDK(sdkDelegate: self, launchOptions: launchOptions as NSDictionary?)
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(
        _ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        Helpshift.registerDeviceToken(deviceToken)
        //SDK側にデバイストークンを渡す
        PPNoticeManager.shared.didRegisterForDeviceToken(deviceToken)
    }
    
    /// デバイストークン取得失敗.
    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print( "Failed to register to APNs: \(error)")
    }
    
    /// サイレントプッシュ受信.
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // ジオエリアインサイド検知
        PPNoticeManager.shared.didReceiveRemoteNotification(userInfo) { (code, message) in
            if code == PPNoticeManager.CallBackResult.success {
                print( "success code:\(code)")
            } else {
                print( "failure code:\(code) errorMessage:\(message ?? "")")
            }
            completionHandler(.newData)
        }
        
    }
    
    override func userNotificationCenter(
        _ center: UNUserNotificationCenter, willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // 通知情報を渡して処理
        PPNoticeManager.shared.willPresent(notification)
        
        super.userNotificationCenter(
            center, willPresent: notification, withCompletionHandler: completionHandler)
    }
    
    override func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        PPNoticeManager.shared.didReceive(response)
        
        super.userNotificationCenter(
            center, didReceive: response, withCompletionHandler: completionHandler)
    }
}
