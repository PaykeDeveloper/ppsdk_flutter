import Flutter
import UIKit
// PPSDK機能
import ProfilePassportCore
// 通知機能(通知機能を利用しない場合は必要なし)
import ProfilePassportNotice
// ビーコン機能(ビーコン機能を利用しない場合は必要なし)
import ProfilePassportBeacon

public class PPSDKFlutterPlugin: NSObject, FlutterPlugin {

  enum PPSDKMethods: String {
    case startPPSDK = "startPPSDK"
    case serviceStop = "serviceStop"
    case setGeoServiceEnabled = "setGeoServiceEnabled"
    case updateLocationAndCheckIn = "updateLocationAndCheckIn"
    case setBeaconServiceEnabled = "setBeaconServiceEnabled"
    case getBeaconServiceEnabled = "getBeaconServiceEnabled"
    case getPPUID = "getPPUID"
    case registerUserSegment = "registerUserSegment"
    case getUserSegmentWithKey = "getUserSegmentWithKey"
    case getAllUserSegments = "getAllUserSegments"
    case clearAllUserSegment = "clearAllUserSegment"
    case setPushMemberId = "setPushMemberId"
    case getPushMemberId = "getPushMemberId"
    case setLogLinkId = "setLogLinkId"
    case showUserInformationDisclosure = "showUserInformationDisclosure"
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ppsdk_flutter", binaryMessenger: registrar.messenger())
    let instance = PPSDKFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    // ここにdelegateを設定する
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let method = call.method

    switch method {
      case PPSDKMethods.startPPSDK.rawValue:
        let option = call.arguments as? [String: String]
        result(startPPSDK(option: option ?? [:]))
      case PPSDKMethods.serviceStop.rawValue:
        serviceStop()
        result(nil)
      case PPSDKMethods.setGeoServiceEnabled.rawValue:
        let flag = call.arguments as? Bool
        setGeoServiceEnabled(flag ?? false)
        result(nil)
      case PPSDKMethods.updateLocationAndCheckIn.rawValue:
        updateLocationAndCheckIn()
        result(nil)
      case PPSDKMethods.setBeaconServiceEnabled.rawValue:
        let flag = call.arguments as? Bool
        setBeaconServiceEnabled(flag ?? false)
        result(nil)
      case PPSDKMethods.getBeaconServiceEnabled.rawValue:
        result(getBeaconServiceEnabled())
      case PPSDKMethods.getPPUID.rawValue:
        result(getPPUID())
      case PPSDKMethods.registerUserSegment.rawValue:
        let args = call.arguments as? [String: String]
        if let key = args?["key"], key.count <= 9, let value = args?["value"], value.count <= 9 {
          result(registerUserSegment(key: args?["key"], value: args?["value"]))
        }else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "key or value is invalid", details: nil))
        }
      case PPSDKMethods.getUserSegmentWithKey.rawValue:
        let key = call.arguments as? String
        result(getUserSegmentWithKey(key ?? ""))
      case getAllUserSegments:
        result(getAllUserSegments())
      case clearAllUserSegment:
        clearAllUserSegment()
        result(nil)
      case PPSDKMethods.setPushMemberId.rawValue:
        let setPushMemberId = call.arguments as? String
        setPushMemberId(setPushMemberId ?? "")
        result(nil)
      case PPSDKMethods.getPushMemberId.rawValue:
        result(getPushMemberId())
      case PPSDKMethods.setLogLinkId.rawValue:
        if logLinkId = call.arguments as String {
          setLogLinkId(logLinkId: logLinkId)
          result(nil)
        }else{
          result(FlutterError(code: "INVALID_ARGUMENT", message: "logLinkId is invalid", details: nil))
        }
      case PPSDKMethods.showUserInformationDisclosure.rawValue:
        showUserInformationDisclosure()
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
    }
  }
}

//PPSDKDelegateを継承（PPGEODelegate, PPNoticeDelegate を使用しない時に使用）
extension PPSDKFlutterPlugin: PPSDKDelegate {
    
}


// PPBeaconDelegate ビーコンイベントをアプリ側で処理をしたいときに実装
extension PPSDKFlutterPlugin : PPBeaconDelegate {
    // ビーコン検知イベント受信処理
    // 【引数】
    // beaconInfo: PPBeaconResult・・・ビーコン検知情報
    //【返り値】
    // Bool・・・通知処理の継続判定
    // true:ローカル通知処理を行う, false:ローカル通知処理を行わない
    func onBeaconEvent(beaconInfo: PPBeaconResult) -> Bool {
        let beaconId = beaconInfo.beaconId          // ビーコンID
        let beaconName = beaconInfo.beaconName      // ビーコン名
        let beaconUuid = beaconInfo.beaconUuid
        let beaconMajor = beaconInfo.beaconMajor
        let beaconMinor = beaconInfo.beaconMinor
        let beaconRssi = beaconInfo.beaconRssi
        let beaconEvent = beaconInfo.beaconEvent    // ビーコンイベント
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


// MARK: - 呼び出されるメソッド群
extension PPSDKFlutterPlugin {
  /// PPSDKを起動する.
  /// - parameter option: 権限周りの設定値.
  /// - returns: 起動成功:true, 失敗:false
  private func startPPSDK(option: [String: String]) -> Bool {
    PPSDKManager.shared.serviceStart(options: option) { status, message in
      print( "PPSDK Status: \(status) message: \(String(describing: message))")
      return status == "0"
    }
  }

  private func serviceStop() {
    PPSDKManager.shared.serviceStop()
  }

  /// ジオサービスの起動状態を変更.
  private func setGeoServiceEnabled(_ flag:Bool) {
    PPSDKManager.shared.setGeoServiceFlag(flag)
  }

  /// ジオ検知機能のチェックイン.
  private func updateLocationAndCheckIn() {
    // options:チェックイン制御用パラメータを設定するオプション ※未実装のためnull
    PPSDKManager.shared.updateLocationAndCheckIn(options: nil) { code, message, result in
        print("チェックイン結果 code: \(code) message:\(String(describing: message)) result:\(String(describing: result))")
        
        if let result = result {
            
            print("チェックイン位置情報: \(String(describing: result.location))")
            
            for inGeo in result.inGeoList {
                print("チェックインジオ情報(ジオID): \(inGeo.geoId)")
                print("チェックインジオ情報(ジオ名): \(inGeo.geoName)")
                print("チェックインジオ情報(ジオ状態): \(inGeo.geoState.rawValue)")
                print("チェックインジオ情報(ジオチェックイン時間): \(String(describing: inGeo.geoCheckInTime))")
                print("チェックインジオ情報(ジオ種別): \(inGeo.geoKind.rawValue)")
                
                if let centerCoordinate = inGeo.centerCoordinate {
                    print("チェックインジオ情報(中心点座標 ※サークルのみ) latitude: \(centerCoordinate.latitude) longitude: \(centerCoordinate.longitude)")
                }
                
                print("チェックインジオ情報(半径 ※サークルのみ): \(inGeo.geoRadius)")
                
                if let apexCoordinates = inGeo.apexCoordinates {
                    for coordinate in apexCoordinates {
                        print("チェックインジオ情報(頂点座標配列 ※ポリゴンのみ) latitude: \(coordinate.latitude) longitude: \(coordinate.longitude)")
                    }
                }
                
                for geoTag in inGeo.geoTags {
                    print("チェックインジオ情報(ジオタグID): \(geoTag.geoTagId)")
                    print("チェックインジオ情報(ジオタグ名): \(geoTag.geoTagName)")
                    print("チェックインジオ情報(ジオタグ状態): \(geoTag.geoTagState.rawValue)")
                    print("チェックインジオ情報(ジオタグチェックイン時間): \(String(describing: geoTag.geoTagCheckInTime))")
                }
            }
        }
    }
  }

  private func setBeaconServiceEnabled(_ flag: Bool) {
    PPSDKManager.shared.setBeaconServiceFlag(isBeaconStart: flag)
  }

  // iosのみ
  private func getBeaconServiceEnabled() -> Bool {
    return PPSDKManager.shared.getBeaconServiceFlag()
  }

  private func getPPUID() -> String {
    return PPSDKManager.shared.getPPUID()
  }

  /// ユーザセグメントの設定
  /// - Parameters:
  ///   - key: 9文字以内での設定
  ///   - value: 9文字以内での設定
  private func registerUserSegment(key: String, value: String) -> Bool {
    let flag = PPSDKManager.shared.setUserSegmentWithKey(key: key, value: value)
    return flag
  }

  private func getUserSegmentWithKey(_ key: String) -> String {
    let value = PPSDKManager.shared.getUserSegmentWithKey(key: key)
    return value
  }

  private func getAllUserSegments() -> NSDictionary {
    let dic:NSDictionary = PPSDKManager.shared.getUserSegmentHash()
    return dic
  }

  private func clearAllUserSegment() {
    PPSDKManager.shared.clearUserSegment()
  }

  private func setPushMemberId(_ setPushMemberId: String) {
    PPSDKManager.shared.setPushMemberId(setPushMemberId)
  }

  private func getPushMemberId() -> String? {
    return PPSDKManager.shared.getPushMemberId()
  }

  private func setLogLinkId(logLinkId: String) {
    PPSDKManager.shared.setLogLinkId(logLinkId: logLinkId)
  }

  /// SDK利用による個別情報開示の同意を得る際、以下の処理を記述します。
  /// 下記のメソッドを、SDK開始前に呼び出してください。
  /// controller : 表示元コントローラ
  /// type : 個別情報開示表示タイプ(PP3CUserInformationDisclosureType)
  ///    webView     : webView画面表示
  ///    dialog      : ダイアログ画面表示
  ///    lowerHalf   : 下半分画面表示
  /// option : 条件
  /// callback: コールバック
  private func showUserInformationDisclosure() {
    PPSDKManager.shared.showUserInformationDisclosure(controller: self, type: .webView, option: nil) {
     // 個別情報開示画面クローズ後処理、
     // 画面表示後で、PPSDKを起動する場合にこちらで実装
    }
  }
}
