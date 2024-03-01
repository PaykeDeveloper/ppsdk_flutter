import 'package:flutter_test/flutter_test.dart';
import 'package:ppsdk_flutter/ppsdk_flutter.dart';
import 'package:ppsdk_flutter/ppsdk_flutter_platform_interface.dart';
import 'package:ppsdk_flutter/ppsdk_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPpsdkFlutterPlatform
    with MockPlatformInterfaceMixin
    implements PpsdkFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PpsdkFlutterPlatform initialPlatform = PpsdkFlutterPlatform.instance;

  test('$MethodChannelPpsdkFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPpsdkFlutter>());
  });

  test('getPlatformVersion', () async {
    PpsdkFlutter ppsdkFlutterPlugin = PpsdkFlutter();
    MockPpsdkFlutterPlatform fakePlatform = MockPpsdkFlutterPlatform();
    PpsdkFlutterPlatform.instance = fakePlatform;

    expect(await ppsdkFlutterPlugin.getPlatformVersion(), '42');
  });
}
