import 'package:flutter_test/flutter_test.dart';
import 'package:ppsdk_flutter/ppsdk_flutter.dart';
import 'package:ppsdk_flutter/ppsdk_flutter_platform_interface.dart';
import 'package:ppsdk_flutter/ppsdk_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPPSDKFlutterPlatform
    with MockPlatformInterfaceMixin
    implements PpsdkFlutterPlatform {
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

void main() {
  final PpsdkFlutterPlatform initialPlatform = PpsdkFlutterPlatform.instance;

  test('$MethodChannelPPSDKFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPPSDKFlutter>());
  });

  // test('getPlatformVersion', () async {
  //   PPSDKFlutter ppsdkFlutterPlugin = PPSDKFlutter();
  //   MockPpsdkFlutterPlatform fakePlatform = MockPpsdkFlutterPlatform();
  //   PpsdkFlutterPlatform.instance = fakePlatform;

  //   expect(await ppsdkFlutterPlugin.getPlatformVersion(), '42');
  // });
}
