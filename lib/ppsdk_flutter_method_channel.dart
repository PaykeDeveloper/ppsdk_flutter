import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ppsdk_flutter_platform_interface.dart';

/// An implementation of [PpsdkFlutterPlatform] that uses method channels.
class MethodChannelPpsdkFlutter extends PpsdkFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ppsdk_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  Future<void> startSDK(Map<String, dynamic> option) async {
    await methodChannel.invokeMethod<String>('startPPSDK', option);
  }

  Future<void> serviceStop() async {
    await methodChannel.invokeMethod<String>('serviceStop');
  }

  Future<void> setGeoServiceEnabled(bool isEnabled) async {
    await methodChannel.invokeMethod<String>('setGeoServiceEnabled', isEnabled);
  }

  Future<void> updateLocationAndCheckIn() async {
    await methodChannel.invokeMethod<String>('updateLocationAndCheckIn');
  }

  Future<void> setBeaconServiceEnabled(bool isEnabled) async {
    await methodChannel.invokeMethod<String>(
        'setBeaconServiceEnabled', isEnabled);
  }

  /// iOS only
  Future<bool?> getBeaconServiceEnabled() async {
    if (Platform.isAndroid) return null;
    return await methodChannel.invokeMethod<bool>('getBeaconServiceEnabled');
  }

  Future<String> getPPUID() async {
    return await methodChannel.invokeMethod('getPPUID');
  }

  Future<bool> registerUserSegment() async {
    return await methodChannel.invokeMethod('registerUserSegment');
  }

  Future<String> getUserSegmentWithKey() async {
    return await methodChannel.invokeMethod('getUserSegmentWithKey');
  }

  Future<Map<String, dynamic>> getAllUserSegments() async {
    return await methodChannel.invokeMethod('getAllUserSegments');
  }

  Future<void> clearAllUserSegment() async {
    await methodChannel.invokeMethod('clearAllUserSegment');
  }

  Future<void> setPushMemberId(String pushMemberId) async {
    await methodChannel.invokeMethod('setPushMemberId', pushMemberId);
  }

  Future<String?> getPushMemberId() async {
    return await methodChannel.invokeMethod('getPushMemberId');
  }

  Future<void> setLogLinkId(String logLinkId) async {
    await methodChannel.invokeMethod('setLogLinkId', logLinkId);
  }
}
