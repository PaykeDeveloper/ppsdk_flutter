import 'ppsdk_flutter_platform_interface.dart';

class PpsdkFlutter {
  Future<String?> getPlatformVersion() {
    return PpsdkFlutterPlatform.instance.getPlatformVersion();
  }
}
