
import 'flutter_cloud_kit_platform_interface.dart';

class FlutterCloudKit {
  Future<String?> getPlatformVersion() {
    return FlutterCloudKitPlatform.instance.getPlatformVersion();
  }
}
