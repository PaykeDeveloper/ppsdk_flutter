// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'ppsdk_flutter_platform_interface.dart';

/// A web implementation of the PpsdkFlutterPlatform of the PpsdkFlutter plugin.
class PpsdkFlutterWeb extends PpsdkFlutterPlatform {
  /// Constructs a PpsdkFlutterWeb
  PpsdkFlutterWeb();

  static void registerWith(Registrar registrar) {
    PpsdkFlutterPlatform.instance = PpsdkFlutterWeb();
  }

  @override
  Future<void> clearAllUserSegment() {
    // TODO: implement clearAllUserSegment
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getAllUserSegments() {
    // TODO: implement getAllUserSegments
    throw UnimplementedError();
  }

  @override
  Future<bool?> getBeaconServiceEnabled() {
    // TODO: implement getBeaconServiceEnabled
    throw UnimplementedError();
  }

  @override
  Future<String> getPPUID() {
    // TODO: implement getPPUID
    throw UnimplementedError();
  }

  @override
  Future<String?> getPushMemberId() {
    // TODO: implement getPushMemberId
    throw UnimplementedError();
  }

  @override
  Future<String> getUserSegmentWithKey() {
    // TODO: implement getUserSegmentWithKey
    throw UnimplementedError();
  }

  @override
  Future<bool> registerUserSegment() {
    // TODO: implement registerUserSegment
    throw UnimplementedError();
  }

  @override
  Future<void> serviceStop() {
    // TODO: implement serviceStop
    throw UnimplementedError();
  }

  @override
  Future<void> setBeaconServiceEnabled(bool isEnabled) {
    // TODO: implement setBeaconServiceEnabled
    throw UnimplementedError();
  }

  @override
  Future<void> setGeoServiceEnabled(bool isEnabled) {
    // TODO: implement setGeoServiceEnabled
    throw UnimplementedError();
  }

  @override
  Future<void> setLogLinkId(String logLinkId) {
    // TODO: implement setLogLinkId
    throw UnimplementedError();
  }

  @override
  Future<void> setPushMemberId(String pushMemberId) {
    // TODO: implement setPushMemberId
    throw UnimplementedError();
  }

  @override
  Future<void> startSDK(Map<String, dynamic> option) {
    // TODO: implement startSDK
    throw UnimplementedError();
  }

  @override
  Future<void> updateLocationAndCheckIn() {
    // TODO: implement updateLocationAndCheckIn
    throw UnimplementedError();
  }

  @override
  Future<void> showUserInformationDisclosure() {
    // TODO: implement showUserInformationDisclosure
    throw UnimplementedError();
  }
}
