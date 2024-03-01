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

  Future<void> callProfilePassportSDK() async {
    await methodChannel.invokeMethod<String>('callProfilePassportSDK');
  }
}
