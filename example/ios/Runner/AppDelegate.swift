import UIKit
import Flutter

// PPSDK機能
import ProfilePassportCore
// 通知機能(通知機能を利用しない場合は必要なし)
import ProfilePassportNotice
// ビーコン機能(ビーコン機能を利用しない場合は必要なし)
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
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
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

//PPSDKDelegateを継承（PPGEODelegate, PPNoticeDelegate を使用しない時に使用）
// extension PPSDKFlutterPlugin: PPSDKDelegate {
    
// }


// PPBeaconDelegate ビーコンイベントをアプリ側で処理をしたいときに実装
extension PPSDKFlutterPlugin : PPBeaconDelegate {
    // ビーコン検知イベント受信処理
    // 【引数】
    // beaconInfo: PPBeaconResult・・・ビーコン検知情報
    //【返り値】
    // Bool・・・通知処理の継続判定
    // true:ローカル通知処理を行う, false:ローカル通知処理を行わない
    func onBeaconEvent(beaconInfo: PPBeaconResult) -> Bool {
        let beaconId = beaconInfo.beaconId      
        let beaconName = beaconInfo.beaconName    
        let beaconUuid = beaconInfo.beaconUuid
        let beaconMajor = beaconInfo.beaconMajor
        let beaconMinor = beaconInfo.beaconMinor
        let beaconRssi = beaconInfo.beaconRssi
        let beaconEvent = beaconInfo.beaconEvent  
        let beaconDwellTime = beaconInfo.beaconDwellTime
        let beaconAtTime = beaconInfo.beaconAtTime
        let beaconLastUpdateTime = beaconInfo.beaconLastUpdateTime
        let beaconCoordinate = beaconInfo.beaconCoordinate
        let beaconProximity = beaconInfo.beaconProximity
        let beaconAccuracy = beaconInfo.beaconAccuracy

        for tag in beaconInfo.beaconTags {
            let tagId = tag.beaconTagId
            let tagName = tag.beaconTagName
            let tagEvent = tag.beaconTagEvent
            let tagAtTime = tag.beaconTagAtTime
            let tagDwellTime = tag.beaconTagDwellTime
            let tagLastUpdateTime = tag.beaconTagLastUpdateTime
        }

        return true

    }
}

// PPGEODelegate ジオイベントを処理したい時に、実装
extension PPSDKFlutterPlugin: PPGEODelegate {
    
    //ジオイベント
    /// - Returns : 通知処理する:
    /// true : 通知処理する（通知あればプッシュ、なければなし）
    /// false: 処理しない（通知があっても、プッシュしない）
    func onGeoEvent(geoInfo: PPGEOResult) -> Bool {
        let geoId = geoInfo.geoId
        let geoName = geoInfo.geoName
        let geoEvent = geoInfo.geoEvent
        let geoDewellTime = geoInfo.geoDwellTime
        let geoAtTime = geoInfo.geoAtTime
        let geoLastUpdateTime = geoInfo.geoLastUpdateTime
        let geoKind = geoInfo.geoKind
        let centerCoordinate = geoInfo.centerCoordinate
        let geoRadius = geoInfo.geoRadius
        let apexCoordinates = geoInfo.apexCoordinates
        let geoTags = geoInfo.geoTags
        
        for tag in geoInfo.geoTags {
            let tagId = tag.geoTagId
            let tagName = tag.geoTagName
            let tagEvent = tag.geoTagEvent
            let geoTagDwellTime = tag.geoTagDwellTime
            let geoTagAtTime = tag.geoTagAtTime
            let geoTagLastUpdateTime = tag.geoTagLastUpdateTime
        }
        return true
    }
    
}


// PPNoticeDelegate 通知イベントを処理したい時に、実装
extension PPSDKFlutterPlugin: PPNoticeDelegate {
    
    /// プッシュ通知前確認
    /// - Returns: プッシュ通知　継続:true、中止:false
    func noticeWillPush(notice: PPNotice) -> Bool {
        let noticeId = notice.id
        let title = notice.title
        let message = notice.message
        let data = notice.data
        let url = notice.url
        let pushStart = notice.pushStart
        let pushEnd = notice.pushEnd
        
        return true;
    }
    
    /// 通知クリック時確認
    /// - Returns: クリックされた通知のURLへの処理　継続:true、中止:false
    func noticeDidClick(notice: PPNotice) -> Bool {
        let noticeId = notice.id
        let title = notice.title
        let message = notice.message
        let data = notice.data
        let url = notice.url
        let pushStart = notice.pushStart
        let pushEnd = notice.pushEnd
        
        return true;
    }
}
