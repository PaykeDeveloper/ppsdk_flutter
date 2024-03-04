import Flutter
import UIKit
import ProfilePassportCore

public class PpsdkFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ppsdk_flutter", binaryMessenger: registrar.messenger())
    let instance = PpsdkFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if let method = call.method, method == "startPPSDK" {
      let option = call.arguments as? [String: String]
      result(startPPSDK(option: option ?? [:]))
    }else{
      result(FlutterMethodNotImplemented)
    }
    // switch call.method {
    // case "getPlatformVersion":
    //   result("iOS " + UIDevice.current.systemVersion)
    // default:
    //   result(FlutterMethodNotImplemented)
    // }
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
}
