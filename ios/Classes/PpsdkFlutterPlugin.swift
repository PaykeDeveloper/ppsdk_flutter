import Flutter
import UIKit
import ProfilePassportCore

public class PpsdkFlutterPlugin: NSObject, FlutterPlugin {

  enum PPSDKMethods: String {
    case startPPSDK
    case serviceStop
    case setGeoServiceEnabled
    case updateLocationAndCheckIn
    case setBeaconServiceEnabled
    case getBeaconServiceEnabled
    case getPPUID
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ppsdk_flutter", binaryMessenger: registrar.messenger())
    let instance = PpsdkFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
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
      default:
        result(FlutterMethodNotImplemented)
    }
  }
}

extension PpsdkFlutterPlugin {
  /// PPSDKを起動する.
  /// - parameter option: 権限周りの設定値.
  /// - returns: 起動成功:true, 失敗:false
  func startPPSDK(option: [String: String]) -> Bool {
    PPSDKManager.shared.serviceStart(options: option) { status, message in
      print( "PPSDK Status: \(status) message: \(String(describing: message))")
      return status == "0"
    }
  }

  //
  func serviceStop() {
    PPSDKManager.shared.serviceStop()
  }

  /// ジオサービスの起動状態を変更.
  func setGeoServiceEnabled(_ flag:Bool) {
    PPSDKManager.shared.setGeoServiceFlag(flag)
  }

  /// ジオ検知機能のチェックイン.
  func updateLocationAndCheckIn() {
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

  func setBeaconServiceEnabled(_ flag: Bool) {
    PPSDKManager.shared.setBeaconServiceFlag(isBeaconStart: flag)
  }

  func getBeaconServiceEnabled() -> Bool {
    return PPSDKManager.shared.getBeaconServiceFlag()
  }

  func getPPUID() -> String {
    return PPSDKManager.shared.getPPUID()
  }
}
