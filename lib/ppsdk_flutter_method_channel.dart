import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ppsdk_flutter_platform_interface.dart';

/// An implementation of [PpsdkFlutterPlatform] that uses method channels.
class MethodChannelPPSDKFlutter extends PpsdkFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ppsdk_flutter');

  @override
  Future<void> startSDK(Map<String, dynamic> option) async {
    await methodChannel.invokeMethod<String>('startPPSDK', option);
  }

  @override
  Future<void> serviceStop() async {
    await methodChannel.invokeMethod<String>('serviceStop');
  }

  @override
  Future<void> setGeoServiceEnabled(bool isEnabled) async {
    await methodChannel.invokeMethod<String>('setGeoServiceEnabled', isEnabled);
  }

  @override
  Future<void> updateLocationAndCheckIn() async {
    await methodChannel.invokeMethod<String>('updateLocationAndCheckIn');
  }

  @override
  Future<void> setBeaconServiceEnabled(bool isEnabled) async {
    await methodChannel.invokeMethod<String>(
        'setBeaconServiceEnabled', isEnabled);
  }

  /// iOS only
  @override
  Future<bool?> getBeaconServiceEnabled() async {
    if (Platform.isAndroid) return null;
    return await methodChannel.invokeMethod<bool>('getBeaconServiceEnabled');
  }

  @override
  Future<String> getPPUID() async {
    return await methodChannel.invokeMethod('getPPUID');
  }

  @override
  Future<bool> registerUserSegment() async {
    return await methodChannel.invokeMethod('registerUserSegment');
  }

  @override
  Future<String> getUserSegmentWithKey() async {
    return await methodChannel.invokeMethod('getUserSegmentWithKey');
  }

  @override
  Future<Map<String, dynamic>> getAllUserSegments() async {
    return await methodChannel.invokeMethod('getAllUserSegments');
  }

  @override
  Future<void> clearAllUserSegment() async {
    await methodChannel.invokeMethod('clearAllUserSegment');
  }

  @override
  Future<void> setPushMemberId(String pushMemberId) async {
    await methodChannel.invokeMethod('setPushMemberId', pushMemberId);
  }

  @override
  Future<String?> getPushMemberId() async {
    return await methodChannel.invokeMethod('getPushMemberId');
  }

  @override
  Future<void> setLogLinkId(String logLinkId) async {
    await methodChannel.invokeMethod('setLogLinkId', logLinkId);
  }

  @override
  Future<void> showUserInformationDisclosure() async {
    await methodChannel.invokeMethod('showUserInformationDisclosure');
  }
}
