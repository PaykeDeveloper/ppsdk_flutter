import 'ppsdk_flutter_platform_interface.dart';

class PPSDKFlutter {
  static final PpsdkFlutterPlatform _platform = PpsdkFlutterPlatform.instance;

  static Future<void> startSDK(Map<String, dynamic> option) async {
    return _platform.startSDK(option);
  }

  static Future<void> serviceStop() async {
    return _platform.serviceStop();
  }

  static Future<void> setGeoServiceEnabled(bool isEnabled) async {
    return _platform.setGeoServiceEnabled(isEnabled);
  }

  static Future<void> updateLocationAndCheckIn() async {
    return _platform.updateLocationAndCheckIn();
  }

  static Future<void> setBeaconServiceEnabled(bool isEnabled) async {
    return _platform.setBeaconServiceEnabled(isEnabled);
  }

  static Future<bool?> getBeaconServiceEnabled() async {
    return _platform.getBeaconServiceEnabled();
  }

  static Future<String> getPPUID() async {
    return _platform.getPPUID();
  }

  static Future<bool> registerUserSegment() async {
    return _platform.registerUserSegment();
  }

  static Future<String> getUserSegmentWithKey() async {
    return _platform.getUserSegmentWithKey();
  }

  static Future<Map<String, dynamic>> getAllUserSegments() async {
    return _platform.getAllUserSegments();
  }

  static Future<void> clearAllUserSegment() async {
    return _platform.clearAllUserSegment();
  }

  static Future<void> setPushMemberId(String pushMemberId) async {
    return _platform.setPushMemberId(pushMemberId);
  }

  static Future<String?> getPushMemberId() async {
    return _platform.getPushMemberId();
  }

  static Future<void> setLogLinkId(String logLinkId) async {
    return _platform.setLogLinkId(logLinkId);
  }
}
