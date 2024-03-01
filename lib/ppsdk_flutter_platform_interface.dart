import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ppsdk_flutter_method_channel.dart';

abstract class PpsdkFlutterPlatform extends PlatformInterface {
  /// Constructs a PpsdkFlutterPlatform.
  PpsdkFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static PpsdkFlutterPlatform _instance = MethodChannelPpsdkFlutter();

  /// The default instance of [PpsdkFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelPpsdkFlutter].
  static PpsdkFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PpsdkFlutterPlatform] when
  /// they register themselves.
  static set instance(PpsdkFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
