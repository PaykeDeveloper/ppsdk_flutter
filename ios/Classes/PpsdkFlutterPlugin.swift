import Flutter
import UIKit

public class PpsdkFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ppsdk_flutter", binaryMessenger: registrar.messenger())
    let instance = PpsdkFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if let method = call.method, method == "callProfilePassportSDK" {
      result(true)
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
